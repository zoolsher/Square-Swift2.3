//
//  WorkBoardViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/9.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SDWebImage


class WorkBoardViewController: UIViewController,UIScrollViewDelegate,UITabBarDelegate,NVActivityIndicatorViewable {

    @IBOutlet weak var placeImageScrollView: UIScrollView!
    
    @IBOutlet weak var tabbar: UITabBar!
    
    var workBoardId = "whatever";
    
    var dataArr = [
        ["image":"https://raw.githubusercontent.com/vsouza/awesome-ios/master/awesome_logo.png"],
        ["image":"http://file.ynet.com/2/1608/09/11576086-500.jpg"]
    ]
    
    var curShowingImage = 0{
        didSet{
            self.showImage(curShowingImage)
            self.middleButton!.title = "\(curShowingImage+1)/\(self.imageArr.count)"
        }
    }
    
    private var imageArr:[String:UIImage] = [String:UIImage]()
    
    var imageInScrollView : UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageInScrollView = UIImageView()
        self.placeImageScrollView.addSubview(imageInScrollView!)
        initRightButton()
        self.placeImageScrollView.delegate = self
        self.tabbar.delegate = self;
        loadingImages()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private var leftButton :UIBarButtonItem? = nil
    private var middleButton : UIBarButtonItem? = nil
    private var rightButton :UIBarButtonItem? = nil
    
    func initRightButton(){
        

        
        leftButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WorkBoardViewController.showLastPic(_:)))
        leftButton?.enabled = false
        
        middleButton = UIBarButtonItem(title: "1/\(self.imageArr.count)", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
//        middleButton?.enabled = false
        
        rightButton = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WorkBoardViewController.showNextPic(_:)))

        self.navigationItem.rightBarButtonItems = [rightButton!,middleButton!,leftButton!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageInScrollView
    }
    
    func showLastPic(_:AnyObject?){
        self.curShowingImage -= 1
        self.middleButton!.title = "\(curShowingImage+1)/\(self.imageArr.count)"
        self.leftButton?.enabled = true
        self.rightButton?.enabled = true
        if curShowingImage == 0 {
            self.leftButton?.enabled = false
        }
    }
    func showNextPic(_:AnyObject?){
        self.curShowingImage += 1
        self.middleButton!.title = "\(curShowingImage+1)/\(self.imageArr.count)"
        self.leftButton?.enabled = true
        self.rightButton?.enabled = true
        if curShowingImage == self.imageArr.count-1{
            self.rightButton?.enabled = false
        }
    }
    
    func loadingImages (){
        
        self.activityStart()
        
        let manager = SDWebImageManager.sharedManager()
        
        for i in 0..<self.dataArr.count{
            manager.downloadImageWithURL(NSURL(string:dataArr[i]["image"]!)!, options: SDWebImageOptions.RetryFailed, progress: { (_, _) in
                
                }, completed: { (image, err, cacheType, finished, imageURL) in
                    let url = imageURL.absoluteString
                    self.imageArr[url] = image
                    if(self.imageArr.count >= self.dataArr.count){
                        self.activityEnd()
                        self.curShowingImage = 0
                    }
            })
        }
        for i in 0..<self.dataArr.count{
            fetchImage(NSURL(string:dataArr[i]["image"]!)!, res: { (image) in
                self.imageArr[self.dataArr[i]["image"]!] = image
                if self.imageArr.count >= self.dataArr.count{
                    self.activityEnd()
                    self.curShowingImage = 0
                }
            })
        }
    }

    
    func fetchImage(url:NSURL,res:(UIImage)->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            Alamofire.request(.GET, url)
                .responseImage { (response) in
                    debugPrint(response)
                    dispatch_async(dispatch_get_main_queue()){
                        if let img = response.result.value {
                            res(img)
                        }
                    }
            }
        }
    }
    
    func showImage(index:Int){
        let url = dataArr[index]["image"]!
        let image = imageArr[url]! as UIImage
        imageInScrollView!.image = image
        imageInScrollView?.frame = CGRect(origin: CGPoint.zero,size: image.size)
        self.placeImageScrollView.contentSize = image.size
        self.placeImageScrollView.bouncesZoom = true
        
        let boundsSize = self.placeImageScrollView.bounds
        var frameToCenter = (imageInScrollView?.frame)!
        if(frameToCenter.size.width < boundsSize.width){
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        }else{
            frameToCenter.origin.x = 0
        }
        if (frameToCenter.size.height < boundsSize.height){
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        }else{
            frameToCenter.origin.y = 0;
        }
        imageInScrollView!.frame = frameToCenter
    }
    
    func triggerSquare(sender: UIButton) {
        if cuttingView == nil{
            initCutting()
        }
        if isCutting {
            endCutting()
            isCutting = false
        }else{
            startCutting()
            isCutting = true
        }
    }
    
    private var pointViewLeftTop:UIView? = nil;
    private var pointViewRightDown:UIView? = nil;
    private var cuttingView : UIView? = nil;
    private var isCutting = false;
    
    func initCutting(){
        var size = CGSize.zero
        size.width = min(self.view.frame.width,self.placeImageScrollView.contentSize.width)
        size.width = min(self.view.frame.width,self.placeImageScrollView.contentSize.height)
        
        var frame = CGRect(origin: self.placeImageScrollView.frame.origin, size: size);
        let banner = CGFloat(20)
        frame.origin.x += banner
        frame.origin.y += banner
        frame.size.width -= 2*banner
        frame.size.height = frame.size.width
        let cutView = UIView(frame: frame)
        cutView.userInteractionEnabled = false
        cutView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
        cutView.layer.borderWidth = CGFloat(3)
        
        let radius = CGFloat(8);
        let dotFrame = CGRect(origin: CGPoint(x:frame.origin.x-radius+1.5,y:frame.origin.y-radius+1.5),size: CGSize(width: 2*radius,height: 2*radius))
        
        let pointView = UIView(frame:dotFrame)
        pointView.backgroundColor = UIColor.whiteColor()
        pointView.userInteractionEnabled = true
        pointView.layer.cornerRadius = radius;
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(WorkBoardViewController.cutPanLeftTop(_:)))
        pointView.addGestureRecognizer(panGesture)
        
        let dotFrame2 = CGRect(origin: CGPoint(x:frame.maxX-radius+1.5,y:frame.maxY-radius+1.5),size: CGSize(width: 2*radius,height: 2*radius))
        let pointView2 = UIView(frame:dotFrame2)
        pointView2.backgroundColor = UIColor.whiteColor()
        pointView2.userInteractionEnabled = true
        pointView2.layer.cornerRadius = radius;
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(WorkBoardViewController.cutPanRightDown(_:)))
        pointView2.addGestureRecognizer(panGesture2)
        
        
        self.cuttingView = cutView
        self.pointViewLeftTop = pointView
        self.pointViewRightDown = pointView2
    }
    
    func cutPanLeftTop(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .Began:
            break;
        case .Changed:
            fallthrough
        case .Ended:
            let offset = sender.translationInView(self.view)
            self.pointViewLeftTop?.center = CGPoint(x: (self.pointViewLeftTop?.center.x)! + offset.x, y: (self.pointViewLeftTop?.center.y)! + offset.y)
            self.cuttingView?.frame.origin = (self.pointViewLeftTop?.center)!
            
            self.pointViewRightDown?.center = CGPoint(x:self.cuttingView!.frame.maxX,y:self.cuttingView!.frame.maxY)
            sender.setTranslation(CGPoint.zero, inView: self.view)
        default:
            break
        }
    }
    
    func cutPanRightDown(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .Began:
            break;
        case .Changed:
            fallthrough
        case .Ended:
            let offset = sender.translationInView(self.view)
            self.pointViewRightDown?.center = CGPoint(x: (self.pointViewRightDown?.center.x)! + offset.x, y: (self.pointViewRightDown?.center.y)! + offset.y)
            self.cuttingView?.frame.size =  CGSize(width: (self.pointViewRightDown?.center)!.x - (self.pointViewLeftTop?.center)!.x,height:(self.pointViewRightDown?.center)!.y - (self.pointViewLeftTop?.center)!.y)
            self.pointViewLeftTop?.center = CGPoint(x:self.cuttingView!.frame.minX,y:self.cuttingView!.frame.minY)
            sender.setTranslation(CGPoint.zero, inView: self.view)
        default:
            break
        }
    }
    
    func startCutting(){
        self.view.addSubview(self.cuttingView!)
        self.view.addSubview(self.pointViewLeftTop!)
        self.view.addSubview(self.pointViewRightDown!)
    }
    func endCutting(){
        print(self.imageInScrollView?.image?.size)
        print(self.getSquareInfo())
        self.cuttingView!.removeFromSuperview()
        self.pointViewLeftTop!.removeFromSuperview()
        self.pointViewRightDown!.removeFromSuperview()
        goToAnotherView()
    }
    
    func getSquareInfo()->(CGPoint,CGSize){
        
        let offset = self.placeImageScrollView.contentOffset
        let scale = self.placeImageScrollView.zoomScale
        let size = self.cuttingView!.frame.size
        let imageO = self.imageInScrollView!.frame.origin
        let origin = self.pointViewLeftTop!.center
        
        let startPoint = CGPoint(x:(origin.x-offset.x-imageO.x)/scale,y:(origin.y-offset.y-64-imageO.y)/scale)
        let squareSize = CGSize(width:size.width/scale,height:size.height/scale)
        
        return (startPoint,squareSize)
        
//        self.pointViewLeftTop?.center - self.placeImageScrollView.frame.origin
        
//        self.pointViewRightDown
        
    }
    func goToAnotherView(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Comment")
        self.showViewController(vc!, sender: nil)
    }
    
    // MARK: tabbar delegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if let index = tabbar.items?.indexOf(item){
            switch index {
            case 0:
                self.triggerSquare(UIButton())
                
                break
            case 1:
                let wbvc = self.storyboard?.instantiateViewControllerWithIdentifier("WorkBoardComments")
                self.showViewController(wbvc!, sender: nil)
                break
            default:
                return
            }
        }
    }
    func activityStart(){
        
        self.startActivityAnimating(self.view.bounds.size, message: "logining...", type: NVActivityIndicatorType.BallTrianglePath, color: UIColor.whiteColor(), padding: 125)
    }
    
    func activityEnd(){
        self.stopActivityAnimating()
    }
    
}

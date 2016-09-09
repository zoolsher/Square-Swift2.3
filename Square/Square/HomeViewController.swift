//
//  ViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/3.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import EasyPeasy
import SwiftyJSON
import NVActivityIndicatorView

class HomeViewController: UIViewController,NVActivityIndicatorViewable {
    
    //MARK:args
    
    
    @IBOutlet weak var segment: SegmentControlView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var goToWorkLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    var isFirstTime : Bool = true;
    var curActiveImage = 1;
    
    //    var scrollViews:[UIScrollView]=[UIScrollView]()
    var scrollViews:[UIView]=[UIView]()
    private var imageViewArr:[UIImageView]? = nil;
    private var imageViewFrameArr:[[CGRect]] = [[CGRect]]();
    
    var headShowArr:[String]?;
    var indexData:JSON = nil;
    var imageURLArr:[String] = [String](){
        didSet{
            self.imageView1.af_setImageWithURL(NSURL(string: imageURLArr[0])!)
            self.imageView2.af_setImageWithURL(NSURL(string: imageURLArr[1])!)
            self.imageView3.af_setImageWithURL(NSURL(string: imageURLArr[2])!)
        }
    };
    //MARK:
    
    //MARK: LifeCyCle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home";
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black;
        self.initTopSlideImages()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToWorks(_:)))
        self.goToWorkLabel.addGestureRecognizer(tapGR)
        self.initSegment()
        
        self.initRightButton()
        self.view.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.00)
    }
    
    func initRightButton(){
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(refreshHandler(_:)))
        self.navigationItem.rightBarButtonItem = barButton
    }
    func refreshHandler(sender:AnyObject?){
        self.queryHomePageData { (err, json) in
            print(json)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //set the selected into nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        if(isFirstTime){
            
            self.initImagePos()
            
            self.queryHomePageData({ (error, json) in
                if(error != nil){
                    
                }else{
                    self.indexData = json!
                    var tempArr = [String]()
                    for (_,subJson):(String, JSON) in json!["affair"] {
                        tempArr.append(subJson["poster"].string!)
                    }
                    self.imageURLArr = tempArr
                    self.scrollViews.append(self.initContainerViewCollection())
                    
                    self.scrollViews.append(self.initContainerViewWorks())
                    
                    self.scrollViews.append(self.initContainerViewCollection())
                    
                    self.view.addSubview(self.scrollViews[1])
                }
            })
            
            
            isFirstTime = false;
            
        }
        self.imageView1.layoutIfNeeded()
        self.imageView2.layoutIfNeeded()
        self.imageView3.layoutIfNeeded()
        for i in 0...2{
            self.imageViewArr?[i].frame = self.imageViewFrameArr[curActiveImage][i]
        }
        
    }
    //MARK:
    
    func initSegment(){
        self.segment.name1 = "Collection"
        self.segment.name2 = "Work"
        self.segment.name3 = "Square"
        self.segment.label1.textColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1.00)
        self.segment.label3.textColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1.00)
        self.segment.labelAction={(lastIndex,index)->Void in
            print(lastIndex,index)
            self.scrollViews[lastIndex].removeFromSuperview()
            self.view.addSubview( self.scrollViews[index] )
        }
    }
    
    static var testURL:String = "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg";
    var arr = [
        ["title":"a","postedBy":"posted by Some","image":testURL],
        ["title":"a","postedBy":"posted by Some","image":testURL],
        ["title":"a","postedBy":"posted by Some","image":testURL]
    ]
    
    /**
     * this is works
     */
    func initContainerViewWorks()->UIScrollView{
        let frame = self.containerView.frame;
        let scrollView = UIScrollView(frame:frame)
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.pagingEnabled = true
        
        for index in 0..<arr.count{
            let workView = WorksOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            workView.imageView.af_setImageWithURL(NSURL(string:arr[index]["image"]!)!)
            //            fetchImage(NSURL(string:arr[index]["image"]!)!, res: { (img) in
            //                workView.loadImg(img)
            //            })
            scrollView.addSubview(workView)
        }
        
        scrollView.contentSize = CGSize(width: frame.size.width*CGFloat(arr.count), height: frame.size.height)
        
        return scrollView
        
    }
    
    func initContainerViewCollection()->UIView{
        let labelHeight = CGFloat(20);
        let frame = CGRect(x:self.containerView.frame.origin.x,
                           y:self.containerView.frame.origin.y,
                           width:self.containerView.frame.height - labelHeight,
                           height:self.containerView.frame.height - labelHeight);
        
        let view = UIView(frame:self.containerView.frame)
        
        
        let labelFrame = CGRect(x:view.frame.width/2,
                                y:0,
                                width:view.frame.width/2,
                                height:CGFloat(labelHeight));
        let viewAllLabel = UILabel(frame:labelFrame);
        viewAllLabel.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.00)
        let viewAllAttributeText = NSMutableAttributedString(string: "View All", attributes:
            [
                NSFontAttributeName:UIFont(name: "DINCOND-Regular", size: 16)!,
            ]);
        let rightAttributedText = NSMutableAttributedString(string: "\u{e642}", attributes:
            [
                NSFontAttributeName:UIFont(name: "iconfont", size:16)!,
            ])
        viewAllAttributeText.appendAttributedString(rightAttributedText)
        viewAllLabel.textAlignment = .Right;
        viewAllLabel.attributedText = viewAllAttributeText
        viewAllLabel.textColor = UIColor(red:0.47, green:0.11, blue:0.13, alpha:1.00)
        viewAllLabel.userInteractionEnabled = true
        let tGR = UITapGestureRecognizer(target: self, action: #selector(collectionViewAllTap(_:)))
        viewAllLabel.addGestureRecognizer(tGR)
        
        view.addSubview(viewAllLabel)
        
        let scrollViewFrame = CGRect(x: 0, y: labelHeight, width: view.frame.width, height: view.frame.height-labelHeight);
        let scrollView = UIScrollView(frame:scrollViewFrame);
        
        scrollView.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.00)
        scrollView.scrollEnabled = true
        
        
        for index in 0..<arr.count{
            let workView = CollectionOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            workView.imageView.af_setImageWithURL(NSURL(string:arr[index]["image"]!)!)
            scrollView.addSubview(workView)
        }
        
        scrollView.contentSize = CGSize(width: frame.size.width*CGFloat(arr.count), height: frame.size.height)
        view.addSubview(scrollView)
        
        return view
        
    }
    
    
    func collectionViewAllTap(sender:AnyObject?){
        print("tap")
        self.performSegueWithIdentifier("GoToCollection", sender: nil)
    }
    
    //MARK: HOME
    
    
    
    
    
    
    //MARK:
    
    //MARK: segue
    func goToWorks(sender:UITapGestureRecognizer){
        //        self.performSegue(withIdentifier: "GoToWork", sender: nil)
        self.performSegueWithIdentifier("GoToWork", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!{
        case "GoToWork":
            //            _ = segue.destinationViewController as! WorkViewController
            break;
        case "GoToNotification":
            //            _ = segue.destinationViewController as! NotificationViewController
            break;
        case "GoToCollection":
            //            _ = segue.destinationViewController as! CollectionViewController
            break;
        default:
            break;
        }
        
    }
    
    
    //MARK:
    
    
    //MARK: - TopSlider Prepare and Update
    
    
    func initTopSlideImages(){
        // add tap gesture recognizer
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        
        imageView1.userInteractionEnabled = true
        imageView2.userInteractionEnabled = true
        imageView3.userInteractionEnabled = true
        
        imageView1.addGestureRecognizer(tapGR1)
        imageView2.addGestureRecognizer(tapGR2)
        imageView3.addGestureRecognizer(tapGR3)
        
        
        
    }
    
    func imageTapHandler(sender:UITapGestureRecognizer){
        // dispatch action
        if(sender.view == imageView1){
            self.updateImagePos(0)
        }else if(sender.view == imageView2){
            self.updateImagePos(1)
        }else{
            self.updateImagePos(2)
        }
    }
    
    func initImagePos(){
        /**
         * init the imageView arr and imageViewFrameArr so it will be faster to use in the animation like `updateImagePos(2)`
         */
        imageViewArr = [UIImageView]();
        imageViewArr?.append(imageView1)
        imageViewArr?.append(imageView2)
        imageViewArr?.append(imageView3)
        var result = CGFloat(0.0);
        for i in imageViewArr!{
            result += i.frame.height
        }
        let nh = result/5;
        let sh = 3*nh;
        let w = imageView1.frame.width;
        let startY = imageView1.frame.origin.y;
        self.imageViewFrameArr = [
            [
                CGRect(x: 0, y: startY + 0, width: w, height: sh),
                CGRect(x: 0, y: startY + sh, width: w, height: nh),
                CGRect(x: 0, y: startY + sh+nh, width: w, height: nh)
            ],
            [
                CGRect(x: 0, y: startY + 0, width: w, height: nh),
                CGRect(x: 0, y: startY + nh, width: w, height: sh),
                CGRect(x: 0, y: startY + sh+nh, width: w, height: nh)
            ],
            [
                CGRect(x: 0, y: startY + 0, width: w, height: nh),
                CGRect(x: 0, y: startY + nh, width: w, height: nh),
                CGRect(x: 0, y: startY + 2*nh, width: w, height: sh)
            ]
        ]
        for i in 0...2{
            self.imageViewArr?[i].frame = self.imageViewFrameArr[1][i]
        }
        return ;
    }
    
    func updateImagePos(index:Int){
        self.curActiveImage = index;
        UIView.animateWithDuration(0.5,
                                   //        (withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 15.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {() -> Void in
                for i in 0...2{
                    self.imageViewArr?[i].frame = self.imageViewFrameArr[index][i]
                }
            },
            completion: nil);
    }
    
    func queryHomePageData(cb:(NSError?,JSON?)->Void){
//        Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        Alamofire.request(.GET, BASE.LOC+"/user/getIndexData",parameters:nil,encoding:.JSON)
            .response(completionHandler: { (request, response, data, error) in
                if (error) != nil {
                    cb(error!,nil)
                }else{
                    if let tempData = data{
                        let json = JSON.init(data: tempData)
                        cb(nil,json)
                    }
                }
            })
        
        
    }
    
    //MARK:
    
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
    
    func activityStart(){
        
        self.startActivityAnimating(self.view.bounds.size, message: "logining...", type: NVActivityIndicatorType.BallTrianglePath, color: UIColor.whiteColor(), padding: 125)
    }
    
    func activityEnd(){
        self.stopActivityAnimating()
    }
    
}


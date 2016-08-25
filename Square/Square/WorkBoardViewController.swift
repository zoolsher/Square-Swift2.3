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
import EasyPeasy
import TOCropViewController
import SwiftyJSON

extension UIImage{
    static func cuttingImage(image:UIImage,withRect rect:CGRect) -> UIImage{
        let i = image.CGImage
        let newi = CGImageCreateWithImageInRect(i, rect)
        return UIImage(CGImage: newi!)
    }
}

private struct Line{
    var startPoint:CGPoint
    var endPoint:CGPoint
}

extension UIView {
    func addDashedBorder(size:CGSize) {
        
        let color = UIColor(red:0.80, green:0.20, blue:0.20, alpha:1.00).CGColor
        let length = min(CGFloat(10),size.width/2,size.height/2)
        
        let lineArr = [
            Line(startPoint: CGPoint(x:0,y:0), endPoint: CGPoint(x:0,y:length)),
            Line(startPoint: CGPoint(x:0,y:0), endPoint: CGPoint(x:length,y:0)),
            Line(startPoint: CGPoint(x:size.width,y:size.height), endPoint: CGPoint(x:size.width,y:size.height-length)),
            Line(startPoint: CGPoint(x:size.width,y:size.height), endPoint: CGPoint(x:size.width-length,y:size.height)),
            Line(startPoint: CGPoint(x:0,y:size.height), endPoint: CGPoint(x:0,y:size.height-length)),
            Line(startPoint: CGPoint(x:0,y:size.height), endPoint: CGPoint(x:length,y:size.height)),
            Line(startPoint: CGPoint(x:size.width,y:0), endPoint: CGPoint(x:size.width-length,y:0)),
            Line(startPoint: CGPoint(x:size.width,y:0), endPoint: CGPoint(x:size.width,y:length)),
        ]
        
        for line in lineArr{
            let line1 = UIBezierPath()
            line1.moveToPoint(line.startPoint)
            line1.addLineToPoint(line.endPoint)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.bounds = CGRect(origin: CGPoint.zero, size:size)
            shapeLayer.position = CGPoint(x: size.width/2, y: size.height/2)
            shapeLayer.fillColor = UIColor.clearColor().CGColor
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            shapeLayer.path = line1.CGPath
            
            self.layer.addSublayer(shapeLayer)
        }
        
    }
}


class WorkBoardViewController: UIViewController,UIScrollViewDelegate,NVActivityIndicatorViewable,TOCropViewControllerDelegate {

    @IBOutlet weak var placeImageScrollView: UIScrollView!

    @IBAction func squareClick(sender: UIButton) {
        if isSquareShowing{
            hideSquares()
            isSquareShowing = false
        }else{
            showSquares()
            isSquareShowing = true
        }
    }
    
    var workBoardId = "whatever";
    
    var dataArr = [
        ["id":"1","image":"https://raw.githubusercontent.com/vsouza/awesome-ios/master/awesome_logo.png" ],
        ["id":"2","image":"http://file.ynet.com/2/1608/09/11576086-500.jpg"]
    ]
    
    var squareArr =
        [
            "1":[
            [
                "framex":"200",
                "framey":"200",
                "width":"100",
                "height":"100",
                "count":"100"
            ],
            [
                "framex":"10",
                "framey":"10",
                "width":"100",
                "height":"100",
                "count":"10"
            ]
            ],
            "2":[
                [
                    "framex":"0",
                    "framey":"0",
                    "width":"10",
                    "height":"10",
                    "count":"100"
                ],
                [
                    "framex":"10",
                    "framey":"10",
                    "width":"200",
                    "height":"100",
                    "count":"10"
                ]
            ]
        ]
    
    internal var workId:String = "10"
    
    private var imageArr:[String:UIImage] = [String:UIImage]()
    
    private var imageViewsInScroll = [UIImageView]()
    
    private var isSquareShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeImageScrollView.delegate = self
        self.initImageViewsInScroll()
        self.initRightButton()
        loadingImages()
    }
    override func viewWillAppear(animated: Bool) {
        loadWorkInfo()
    }
    func loadWorkInfo(){
        self.activityStart()
        if workId == ""{return}
        else{
            guard let url = NSURL(string:BASE.LOC+"/works/getWorkPiecesById/\(self.workId)") else {return}
            Alamofire.request(.GET, url)
                .response{ request, response, data, error in
                    self.activityEnd()
                    if (error != nil){
                        let alert = UIAlertController(title: "网络错误", message: "网络错误", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "好吧", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }else{
                        let json = JSON(data: data!)
                        print(json[0])
                    }
            }
        }
    }
    
    
    func initRightButton(){
        let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(goToCropView(_:)))
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func goToCropView(sender:AnyObject?){
        let image = imageArr[dataArr[0]["image"]!]!
        
        let cropViewController = TOCropViewController.init(image: image)
        cropViewController.aspectRatioPickerButtonHidden = true
        cropViewController.delegate = self
        self.presentViewController(cropViewController, animated: true, completion: nil)
    }
    
    func cropViewController(cropViewController: TOCropViewController!, didFinishCancelled cancelled: Bool) {
        cropViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cropViewController(cropViewController: TOCropViewController!, didCropToImage image: UIImage!, withRect cropRect: CGRect, angle: Int) {
        print(angle)
        print(cropRect)
        cropViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initImageViewsInScroll(){
        self.placeImageScrollView.pagingEnabled = true
        self.placeImageScrollView.alwaysBounceHorizontal = true
        self.placeImageScrollView.alwaysBounceVertical = false
        var lastView:UIView? = nil
        for _ in 0..<dataArr.count{
            let imageView =  UIImageView()
            placeImageScrollView.addSubview(imageView)
            if let consView = lastView {
                imageView <- [
                    Size().like(placeImageScrollView),
                    Left().to(consView,.Right),
                    Top().to(placeImageScrollView)
                ]
            }else{
                imageView <- [
                    Size().like(placeImageScrollView),
                    Left().to(self.placeImageScrollView,.Left),
                    Top().to(placeImageScrollView)
                ]
            }
            imageView.contentMode = .ScaleAspectFit
            imageView.backgroundColor = UIColor.blackColor()
            lastView = imageView
            self.imageViewsInScroll.append(imageView)
        }
    }
    
    var squaresAreInit = false
    var squaresArr = [UIView]()
    func showSquares(){
        if !squaresAreInit {
            for index in 0..<dataArr.count{
                guard let id = dataArr[index]["id"] else {continue}
                guard let squares = squareArr[id] else {continue}
                for i in 0..<squares.count{
                    let square = squares[i]
                    let x = CGFloat(NSNumberFormatter().numberFromString(square["framex"] ?? "0") ?? 0)
                    let y = CGFloat(NSNumberFormatter().numberFromString(square["framey"] ?? "0") ?? 0)
                    let width = CGFloat(NSNumberFormatter().numberFromString(square["width"] ?? "0") ?? 0)
                    let height = CGFloat(NSNumberFormatter().numberFromString(square["height"] ?? "0") ?? 0)
                    let frame = CGRect(x: x, y: y, width: width, height: height)
                    
                    let image = UIImage.cuttingImage(self.imageArr[dataArr[index]["image"]!]!, withRect: frame)
                    let squareFrame = self.addSquareForImageView(frame, imageView: self.imageViewsInScroll[index])
                    
                    let squareView = UIImageView()
                    squareView.image = image
                    squareView.contentMode = .ScaleToFill
                    self.placeImageScrollView.addSubview(squareView)
                    squareView <- [
                        Size(squareFrame.size),
                        Top(squareFrame.origin.y).to(self.imageViewsInScroll[index],.Top),
                        Left(squareFrame.origin.x).to(self.imageViewsInScroll[index],.Left)
                    ]
                    
                    squareView.addDashedBorder(squareFrame.size)
                    
//                    squareView.layer.borderColor = UIColor.redColor().CGColor
//                    squareView.layer.borderWidth = CGFloat(1)
                    
                    squaresArr.append(squareView)
                }
            }
            squaresAreInit = true
        }else{
            for view in squaresArr{
                view.hidden = false
            }
        }
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 15.0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: { 
                                    self.imageViewsInScroll.map { (imageView) -> Void in
                                        imageView.alpha = 0.5
                                    }
            },
                                   completion: nil
        )
        
    }
    
    func hideSquares(){
        for view in squaresArr{
            view.hidden = true
        }
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 15.0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    self.imageViewsInScroll.map { (imageView) -> Void in
                                        imageView.alpha = 1.0
                                    }
            },
                                   completion: nil
        )
    }
    
    override func viewDidAppear(animated: Bool) {
        self.placeImageScrollView.contentSize = CGSize(width: self.imageViewsInScroll[0].frame.width * CGFloat(dataArr.count), height: self.imageViewsInScroll[0].frame.height)
    }
    
    func loadImagesIntoView(){
        for index in 0..<dataArr.count{
            let imageURL = dataArr[index]["image"]!
            if let image = self.imageArr[imageURL] {
                self.imageViewsInScroll[index].image = image
            }else{
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        self.loadImagesIntoView()
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
    
    func activityStart(){
        self.startActivityAnimating(self.view.bounds.size, message: "logining...", type: NVActivityIndicatorType.BallTrianglePath, color: UIColor.whiteColor(), padding: 125)
    }
    
    func activityEnd(){
        self.stopActivityAnimating()
    }
    
    func addSquareForImageView(square:CGRect,imageView:UIImageView) -> CGRect{
        guard let imageSize = imageView.image?.size else {return CGRect.zero}
        let viewSize = imageView.bounds
        _ = square
        let xScale = imageSize.width/viewSize.width
        let yScale = imageSize.height/viewSize.height
        var scale = CGFloat(0.0)
        var xStart = CGFloat(0.0)
        var yStart = CGFloat(0.0)
        
        if xScale > yScale {
            scale = xScale
            yStart = viewSize.height/2.0 - imageSize.height/(2*scale)
        }else{
            scale = yScale
            xStart = viewSize.width/2.0 - imageSize.width/(2*scale)
        }
        
        var newSquareFrame = square
        newSquareFrame.origin.x = square.origin.x / scale + xStart
        newSquareFrame.origin.y = square.origin.y / scale + yStart
        newSquareFrame.size.width = square.size.width / scale
        newSquareFrame.size.height = square.size.height / scale
        
        return newSquareFrame
    }

}

//
//  NotificationViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/7.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

import Alamofire

class NotificationViewController: UIViewController {

    @IBOutlet weak var segment: SegmentControlView!
    
    var segmentViews = [UIView]()
    
    private var curView:UIView? = nil;
    
    private var containerView : UIView? = nil
    
    private var commentDelegate1 : CommentDelegate? = nil
    private var commentDelegate2 : CommentDelegate? = nil
    private var notificationDeletgate : NotificationDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSegmentViews()
        
        self.segment.name1 = "Message"
        self.segment.name2 = "Comment"
        self.segment.name3 = "Notification"
        self.segment.labelAction = {
            (lastIndex,index) in
            UIView.animateWithDuration(0.5,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 15.0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        self.containerView!.frame = CGRect(x: -self.view.frame.width*CGFloat(index), y: self.view.frame.origin.y, width: self.view.frame.width*3, height: self.view.frame.height)
//                                        if let temp = self.segmentViews[index] as? UITableView {
//                                            temp.reloadData()
//                                        }
                },
                                       completion: nil)
        }
//        self.view.insertSubview(self.segmentViews[1], atIndex: 0)
//        curView = self.segmentViews[1]
        // Do any additional setup after loading the view.
    }

    func initSegmentViews(){
        let frame = self.view.frame
        self.containerView = UIView(frame: CGRect(origin: frame.origin, size: CGSize(width: frame.width*3, height: frame.height)))
        
        
        self.commentDelegate1 = CommentDelegate()
        self.commentDelegate2 = CommentDelegate()
        self.notificationDeletgate = NotificationDelegate(vc: self)
        let base = commentDelegate1!.initWithFrame(CGRect(origin: CGPoint(x: frame.width*CGFloat(0), y:frame.origin.y), size: frame.size))
        let comment = commentDelegate2!.initWithFrame(CGRect(origin: CGPoint(x: frame.width*CGFloat(1), y:frame.origin.y), size: frame.size))
        let notification = notificationDeletgate!.initWithFrame(CGRect(origin: CGPoint(x: frame.width*CGFloat(2), y:frame.origin.y), size: frame.size))
        
        self.segmentViews.append(base)
        self.segmentViews.append(comment)
        self.segmentViews.append(notification)
        
        
        for i in 0..<3 {
            let tempFrame = CGRect(origin: CGPoint(x: frame.width*CGFloat(i), y:frame.origin.y), size: frame.size)
            self.segmentViews[i].frame = tempFrame
            self.containerView?.addSubview(self.segmentViews[i])
        }
        self.view.insertSubview(self.containerView!, atIndex: 0)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ChatViewController
        vc.dataSource  = FakeDataSource(messages: TutorialMessageFactory.createMessages().map { $0 }, pageSize: 50)
        vc.messageSender = vc.dataSource.messageSender
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

}

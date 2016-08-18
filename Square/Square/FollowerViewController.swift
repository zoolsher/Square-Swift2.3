//
//  FollowerViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/13.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import EasyPeasy

class FollowerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var segment: SegmentControlView!
    
    @IBOutlet weak var containerView: UIView!
    
    var followerView:UITableView? = nil
    
    var followingView:UITableView? = nil
    
    var followerData:[[String:String]] = [[String:String]]()
    
    var followingData:[[String:String]] = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.title = "Follower"
        self.segment.name1 = "Followers"
        self.segment.name2 = "Following"
        self.segment.labelAction = {(lastIndex,index) in
            
            if index == 1 {
                self.followingView?.hidden = true
                self.followerView?.hidden = false
            }else{
                self.followingView?.hidden = false
                self.followerView?.hidden = true
            }
            var newFrame = self.containerView.frame
            newFrame.origin.x = (0-CGFloat(index)) * self.view.frame.width
            self.containerView.frame = newFrame
            
//            UIView.animateWithDuration(0.5,
//                delay: 0.0,
//                usingSpringWithDamping: 0.5,
//                initialSpringVelocity: 15.0,
//                options: UIViewAnimationOptions.CurveEaseInOut,
//                animations: {() -> Void in
//                    if index == 1 {
//                        self.followingView?.hidden = true
//                        self.followerView?.hidden = false
//                    }else{
//                        self.followingView?.hidden = false
//                        self.followerView?.hidden = true
//                    }
//                    var newFrame = self.containerView.frame
//                    newFrame.origin.x = (0-CGFloat(index)) * self.view.frame.width
//                    self.containerView.frame = newFrame
//                },
//                completion: nil);
        }
        followerData = [
            ["username":"zhang","intro":"from QingHua","avator":"http://touxiang.vipyl.com/user/webimg/2012118/2012118162813661.jpg"],
            ["username":"zhang","intro":"from QingHua","avator":"http://touxiang.vipyl.com/user/webimg/2012118/2012118162813661.jpg"],
            ["username":"zhang","intro":"from QingHua","avator":"http://touxiang.vipyl.com/user/webimg/2012118/2012118162813661.jpg"],
        ]
        followingData = followerData
        initContainerView()
        // Do any additional setup after loading the view.
    }
    
    let reuse = "_followerTableViewCell"
    
    func initContainerView(){
        
        followerView = UITableView(frame: CGRect.zero)
        self.containerView.addSubview(followerView!)
        followerView! <- [
            Width(*0.5).like(self.containerView),
            Height().like(self.containerView),
            CenterY(0).to(self.containerView),
            Right(0).to(self.containerView)
        ]
        followerView?.delegate = self
        followerView?.dataSource = self
        let followerViewCell = UINib(nibName: "FolllowerTableViewCell", bundle: nil)
        followerView?.registerNib(followerViewCell, forCellReuseIdentifier: reuse)
        followerView?.rowHeight = 75
        followerView?.backgroundColor = UIColor.blackColor()
        
        followingView = UITableView(frame : CGRect.zero)
        self.containerView.addSubview(followingView!)
        followingView! <- [
            Width(*0.5).like(self.containerView),
            Height().like(self.containerView),
            CenterY(0).to(self.containerView),
            Left(0).to(self.containerView)
        ]
        followingView?.delegate = self
        followingView?.dataSource = self
        let followerViewCell2 = UINib(nibName: "FolllowerTableViewCell", bundle: nil)
        followingView?.registerNib(followerViewCell2, forCellReuseIdentifier: reuse)
        followingView?.rowHeight = 75
        followingView?.backgroundColor = UIColor.blackColor()
        
        self.followingView?.hidden = true
        self.followerView?.hidden = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch tableView {
        case followingView!:
            return 1
        case followerView!:
            return 1
        default:
            assert(false, "unhandle tableview")
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case followingView!:
            return followingData.count
        case followerView!:
            return followerData.count
        default:
            assert(false)
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch tableView {
        case followerView!:
            let cell = followerView?.dequeueReusableCellWithIdentifier(reuse) as! FolllowerTableViewCell
            let data = followerData[indexPath.row]
            cell.loadData(data["username"]!, intro: data["intro"]!)
            cell.avator.sd_setImageWithURL(NSURL(string:data["avator"]!)!)
            cell.backgroundColor = cell.contentView.backgroundColor
            return cell
        case followingView!:
            let cell = followingView?.dequeueReusableCellWithIdentifier(reuse) as! FolllowerTableViewCell
            let data = followingData[indexPath.row]
            cell.loadData(data["username"]!, intro: data["intro"]!)
            cell.avator.sd_setImageWithURL(NSURL(string:data["avator"]!)!)
            cell.backgroundColor = cell.contentView.backgroundColor
            return cell
        default:
            let cell = followingView?.dequeueReusableCellWithIdentifier(reuse) as! FolllowerTableViewCell
            let data = followingData[indexPath.row]
            cell.loadData(data["username"]!, intro: data["intro"]!)
            cell.avator.sd_setImageWithURL(NSURL(string:data["avator"]!)!)
            cell.backgroundColor = cell.contentView.backgroundColor
            return cell

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier("Profile") as! ProfileViewController
        profileVC.isUserSelf = false
        self.showViewController(profileVC, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

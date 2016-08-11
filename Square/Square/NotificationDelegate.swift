//
//  CommentDelegate.swift
//  Square
//
//  Created by zoolsher on 2016/8/7.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class NotificationDelegate:NSObject,UITableViewDelegate,UITableViewDataSource{
    
    func initWithFrame(frame:CGRect)->UIView{
        let comment = UITableView()
        comment.backgroundColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        comment.separatorColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.00)
        comment.registerNib(UINib.init(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: resue)
        comment.dataSource = self;
        comment.delegate = self;
        comment.rowHeight = UITableViewAutomaticDimension
        comment.estimatedRowHeight = 200
        comment.frame = frame
        comment.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0)
        commentTableViewCellProto = comment.dequeueReusableCellWithIdentifier(resue) as? NotificationTableViewCell
        comment.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30+64))
        return comment
        
    }
    
    let imageURL:String = "http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg";
    
    var commentData = [
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ]
    
    private var commentTableViewCellProto:NotificationTableViewCell? = NotificationTableViewCell()
    
    private let resue = "_notificationTableViewCell"
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.commentData[indexPath.row]
        commentTableViewCellProto?.loadData(data["username"]!, action: data["comment"]!, time: data["time"]!)
        let size = commentTableViewCellProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let retheight = (size?.height)! > 58 ? (size?.height)! : 58
        return retheight + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.commentData[indexPath.row]
        commentTableViewCellProto?.loadData(data["username"]!, action: data["comment"]!, time: data["time"]!)
        let size = commentTableViewCellProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let retheight = (size?.height)! > 58 ? (size?.height)! : 58
        return retheight + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.commentData[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(self.resue) as? NotificationTableViewCell
        if let reuseCell = cell{
            reuseCell.loadData(data["username"]!, action: data["comment"]!, time: data["time"]!)
            fetchImage(NSURL(string:data["avator"]!)!, res: { (img) in
                reuseCell.loadImage(img)
            })
            reuseCell.backgroundColor = reuseCell.contentView.backgroundColor
            return reuseCell
        }else{
            let newCell = NotificationTableViewCell()
            newCell.loadData(data["username"]!, action: data["comment"]!, time: data["time"]!)
            fetchImage(NSURL(string:data["avator"]!)!, res: { (img) in
                newCell.loadImage(img)
            })
            newCell.backgroundColor = newCell.contentView.backgroundColor
            return newCell
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
}
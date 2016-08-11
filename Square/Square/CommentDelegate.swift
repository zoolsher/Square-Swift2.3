//
//  CommentDelegate.swift
//  Square
//
//  Created by zoolsher on 2016/8/7.
//  Copyright © 2016年 SquareCom. All rights reserved.
//


import UIKit
import Alamofire

class CommentDelegate:NSObject,UITableViewDelegate,UITableViewDataSource{
    
    let imageURL:String = "http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg";
    
    var commentData = [
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","myWork":"my work:\n this\n is my work\n what do you think of it?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","myWork":"my work: this is my work what do you think of it?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ["username":"nana zhou","comment":"what is this? who is that? where do you come from? how do you do? what?","myWork":"my work: this is my work what do you think of it?","time":"JUL 9","avator":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg"],
        ]
    
    private var commentTableViewCellProto:CommentTableViewCell? = CommentTableViewCell()
    
    private let reuseForComment = "_commentTableViewCell"
    
    func initWithFrame(frame:CGRect)->UIView{
        let comment = UITableView()
        comment.backgroundColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        comment.separatorColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.00)
        comment.registerNib(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: reuseForComment)
        comment.dataSource = self;
        comment.delegate = self;
        comment.rowHeight = UITableViewAutomaticDimension
        comment.estimatedRowHeight = 100
        comment.frame = frame
        comment.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0)
        commentTableViewCellProto = comment.dequeueReusableCellWithIdentifier(reuseForComment) as? CommentTableViewCell
        comment.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30+64))
        return comment
        
    }
    
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.commentData[indexPath.row]
        commentTableViewCellProto?.loadData(data["username"]!, time: data["time"]!, comment: data["comment"]!, myWork: data["myWork"]!)
        let size = commentTableViewCellProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let commentSize = commentTableViewCellProto?.commentTextview.sizeThatFits(CGSize(width:commentTableViewCellProto!.commentTextview.frame.size.width,height: CGFloat.max))
        
        let retheight = (commentSize?.height)!+(size?.height)!
        
        print(retheight)
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
        commentTableViewCellProto?.loadData(data["username"]!, time: data["time"]!, comment: data["comment"]!, myWork: data["myWork"]!)
        let size = commentTableViewCellProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let commentSize = commentTableViewCellProto?.commentTextview.sizeThatFits(CGSize(width:commentTableViewCellProto!.commentTextview.frame.size.width,height: CGFloat.max))
        let retheight = (commentSize?.height)!+(size?.height)!
        print(retheight)
        return retheight + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.commentData[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseForComment) as? CommentTableViewCell
        if let reuseCell = cell{
            reuseCell.loadData(data["username"]!, time: data["time"]!, comment: data["comment"]!, myWork: data["myWork"]!)
            fetchImage(NSURL(string:data["avator"]!)!, res: { (img) in
                reuseCell.loadImage(img)
            })
            reuseCell.backgroundColor = reuseCell.contentView.backgroundColor
            return reuseCell
        }else{
            let newCell = CommentTableViewCell()
            newCell.loadData(data["username"]!, time: data["time"]!, comment: data["comment"]!, myWork: data["myWork"]!)
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
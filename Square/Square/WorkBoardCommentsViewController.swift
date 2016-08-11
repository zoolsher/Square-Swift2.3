//
//  WorkBoardCommentsViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/10.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class WorkBoardCommentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    static let imageURL:String = "http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg";
    var data = [
        ["username":"who","title":"student","image":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg","comment":"i don not know what is this ha ha hah h h h hh hasdfasdf sdaf jasdf asdf asd asf"],
        
        ["username":"who","title":"student","image":"http://p3.qqgexing.com/touxiang/20120804/1231/501ca5abbc54a.jpg","comment":"i don not know what is this ha ha hah h h h hh hasdfasdf sdaf jasdf asdf asd asf"]
    ]
    var reuse = "_workBoardCommentCell"
    var commentTableViewProto : WorkBoardCommentTableViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView(){
        let cell = UINib.init(nibName: "WorkBoardCommentTableViewCell", bundle: nil)
        self.tableview.registerNib(cell, forCellReuseIdentifier: reuse)
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 100
        self.tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.backgroundColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        self.tableview.separatorColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.00)
        commentTableViewProto = self.tableview.dequeueReusableCellWithIdentifier(reuse) as? WorkBoardCommentTableViewCell
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.data[indexPath.row]
        commentTableViewProto?.loadData(data["username"]!, userTitle: data["title"]!, comment: data["comment"]!)
        let size = commentTableViewProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let textViewSize = commentTableViewProto?.commentContentTextView.sizeThatFits(CGSize(width:commentTableViewProto!.commentContentTextView.frame.width,height:CGFloat.max))
        let retHeight = (size?.height)! + (textViewSize?.height)!
        return retHeight + 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.data[indexPath.row]
        commentTableViewProto?.loadData(data["username"]!, userTitle: data["title"]!, comment: data["comment"]!)
        let size = commentTableViewProto?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let textViewSize = commentTableViewProto?.commentContentTextView.sizeThatFits(CGSize(width:commentTableViewProto!.commentContentTextView.frame.width,height:CGFloat.max))
        let retHeight = (size?.height)! + (textViewSize?.height)!
        return retHeight + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        let cell = tableview.dequeueReusableCellWithIdentifier(reuse) as? WorkBoardCommentTableViewCell
        cell?.loadData(data["username"]!, userTitle: data["title"]!, comment: data["comment"]!)
        cell?.backgroundColor = cell?.contentView.backgroundColor
        return cell!
    }
}

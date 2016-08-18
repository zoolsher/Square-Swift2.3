//
//  SquareViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/16.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import EasyPeasy
import SABlurImageView

class SquareViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var tableView:UITableView? = nil
    private var imageView:SABlurImageView? = nil
    private var clickView:UIView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        self.view.backgroundColor = UIColor.blackColor()
        self.imageView = SABlurImageView()
        guard let imageView = self.imageView else {return}
        let image = UIImage.init(named: "pic-test-3")
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        let viewHeight = CGFloat(250)//self.view.frame.width/(imageSize?.width)! * (imageSize?.height)!
        self.view.addSubview(imageView)
        imageView <- [
            Width().like(self.view),
            Height(viewHeight),
            Top().to(self.topLayoutGuide)
        ]
        
        self.tableView = UITableView()
        guard let tableView = self.tableView else {return}
        self.view.addSubview(tableView)
        tableView <- [
            Width().like(self.view),
            Height().like(self.view),
            CenterX().to(self.view),
            Top().to(imageView)
        ]
        tableView.backgroundColor = UIColor.blackColor()
        
        tableView.userInteractionEnabled = false
        imageView.userInteractionEnabled = false
        
        self.clickView = UIView()
        self.view.addSubview(clickView!)
        guard let clickView = self.clickView else{ return }
        clickView.frame = self.view.frame
        let swipe = UISwipeGestureRecognizer(target: self,action:#selector(swiperHandler(_:)))
        let ges = UIPanGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        clickView.addGestureRecognizer(ges)
        clickView.addGestureRecognizer(swipe)
        self.view.translatesAutoresizingMaskIntoConstraints = true
        initTableView()
    }
    
    private let levelOneReuseId = "_commentLevelOneTableViewCell"
    private let levelTwoReuseId = "_commentLevelTwoTableViewCell"
    func initTableView(){
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 50
        let commentViewLevelOneTableViewCell = UINib(nibName: "CommentLevelOneTableViewCell", bundle: nil)
        self.tableView?.registerNib(commentViewLevelOneTableViewCell, forCellReuseIdentifier: levelOneReuseId)
        let commentViewLevleTwoTableViewCell = UINib(nibName: "CommentLevelTwoTableViewCell", bundle: nil)
        self.tableView?.registerNib(commentViewLevleTwoTableViewCell, forCellReuseIdentifier: levelTwoReuseId)
        self.tableView?.separatorStyle = .None
//        self.tableView?.alwaysBounceVertical = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelOneReuseId) as? CommentLevelOneTableViewCell
            var str = "aab"
            for _ in 0...50{
                str+="abb"
            }
            cell!.commentLabel.text = str;
            return cell!
            break;
        case 1:
            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelTwoReuseId) as? CommentLevelTwoTableViewCell
            var str = "aab"
            for _ in 0...50{
                str+="abb"
            }
            cell?.commentLabel.text = str
            return cell!
            break;
        default:
            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelTwoReuseId) as? CommentLevelTwoTableViewCell
            var str = "aab"
            for _ in 0...50{
                str+="abb"
            }
            cell?.commentLabel.text = str
            return cell!
            break;
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
//        tableView?.userInteractionEnabled = false
//        imageView?.userInteractionEnabled = false
//        clickView?.userInteractionEnabled = true
//        scrollView.resignFirstResponder()
//        scrollview
//        self.clickView?.becomeFirstResponder()
//        scrollView.nextResponder()?.becomeFirstResponder()
        if(scrollView.contentOffset.y < 0){
            self.hideTheTable()
        }
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row == 1{
//            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelOneReuseId) as! CommentLevelOneTableViewCell
//            let cellSize = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//            let textSize = cell.commentTextView.sizeThatFits(CGSize(width: cell.commentTextView.frame.width,height:CGFloat.max))
//            print(textSize.height)
//            if textSize.height > 50{
//                return cellSize.height - 50 + textSize.height + 8
//            }else{
//                return cellSize.height + 1
//            }
//        }else{
//            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelTwoReuseId) as! CommentLevelTwoTableViewCell
//            //let cellSize = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//            let textSize = cell.commentTextView.sizeThatFits(CGSize(width: cell.commentTextView.frame.width,height:CGFloat.max))
//            if textSize.height > 50{
//                return textSize.height + 1 + 16
//            }else{
//                return 51
//            }
//            
//        }
//
//    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row == 1{
//            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelOneReuseId) as! CommentLevelOneTableViewCell
//            let cellSize = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//            let textSize = cell.commentTextView.sizeThatFits(CGSize(width: cell.commentTextView.frame.width,height:CGFloat.max))
//            print(textSize.height)
//            if textSize.height > 50{
//                return cellSize.height - 50 + textSize.height + 8
//            }else{
//                return cellSize.height + 1
//            }
//        }else{
//            let cell = self.tableView?.dequeueReusableCellWithIdentifier(levelTwoReuseId) as! CommentLevelTwoTableViewCell
//            //let cellSize = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//            let textSize = cell.commentTextView.sizeThatFits(CGSize(width: cell.commentTextView.frame.width,height:CGFloat.max))
//            if textSize.height > 50{
//                return textSize.height + 1 + 16
//            }else{
//                return 51
//            }
//        
//        }
//    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func swiperHandler(sender:UISwipeGestureRecognizer){
        print ("swiper")
        if sender.direction == .Up{
            if self.imageViewStartPoint == nil {
                self.imageViewStartPoint = self.imageView?.frame.origin
                self.tableViewStartPoint = self.tableView?.frame.origin
                self.tableViewEndPoint = self.imageView?.frame.origin
                var point = self.imageView?.frame.origin
                point!.y -= (self.imageView?.frame.height)!/3
                self.imageViewEndPoint = point
            }
            showTheTable()
        }
    }
    
    private var startPoint:CGPoint? = nil
    private var imageViewStartPoint:CGPoint? = nil
    private var tableViewStartPoint:CGPoint? = nil
    private var tableViewEndPoint : CGPoint? = nil
    private var imageViewEndPoint : CGPoint? = nil
    private var isTableViewShowing = false
    func tapHandler(sender:UIPanGestureRecognizer){
        switch sender.state{
        case .Began:
            if self.imageViewStartPoint == nil {
                self.imageViewStartPoint = self.imageView?.frame.origin
                self.tableViewStartPoint = self.tableView?.frame.origin
                self.tableViewEndPoint = self.imageView?.frame.origin
                var point = self.imageView?.frame.origin
                point!.y -= (self.imageView?.frame.height)!/3
                self.imageViewEndPoint = point
            }
            startPoint = sender.translationInView(self.view)
            fallthrough
        case .Changed:
            let move = sender.translationInView(self.view)
            guard let imageView = self.imageView else {return}
            guard let tableView = self.tableView else {return}
            var frame = tableView.frame
            frame.origin.y += move.y
            tableView.frame = frame
            
            let percent = (frame.origin.y - tableViewStartPoint!.y) / (tableViewEndPoint!.y - tableViewStartPoint!.y)
            let y = (imageViewEndPoint!.y - imageViewStartPoint!.y)*percent + imageViewStartPoint!.y
            
            imageView.frame.origin = CGPoint(x:imageView.frame.origin.x, y:y)
            
            sender.setTranslation(CGPoint.zero, inView: self.view)
            break
        case .Ended:
            let y = imageView!.frame.origin.y
            print(imageViewStartPoint)
            print(imageViewEndPoint)
            print(y)
            if isTableViewShowing{
                if 0.3*abs(y-imageViewStartPoint!.y) > abs(y-imageViewEndPoint!.y){
                    showTheTable()
                }else{
                    hideTheTable()
                }
            }else{
                if abs(y-imageViewStartPoint!.y) > 0.3*abs(y-imageViewEndPoint!.y){
                    showTheTable()
                }else{
                    hideTheTable()
                }
            }
            break
        default:
            break
        }
    
    }
    
    func showTheTable(time:NSTimeInterval = 0.5){
        isTableViewShowing = true
//        self.imageView!.addBlurEffect(20)
        guard let imageView = self.imageView else {return}
        guard let tableView = self.tableView else {return}
        tableView.userInteractionEnabled = true
//        imageView.frame = CGRect(origin: self.imageViewEndPoint!, size:self.imageView!.frame.size)
//        tableView.frame = CGRect(origin: self.tableViewEndPoint!, size:self.tableView!.frame.size)
        
        
        UIView.animateWithDuration(time,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    tableView <- [
                                        Top().to(self.topLayoutGuide)
                                    ]
                                    imageView <- [
                                        Top(self.imageViewEndPoint!.y).to(self.topLayoutGuide)
                                    ]
                                    self.view.layoutIfNeeded()
                                    self.tableView?.layoutIfNeeded()
                                    self.imageView?.layoutIfNeeded()
            },
                                   completion: { finished in
                                    
                                    self.view.sendSubviewToBack(self.clickView!)
//                                    self.clickView?.userInteractionEnabled = false
            }
        )
    }
    
    func hideTheTable(time:NSTimeInterval = 0.5){
        isTableViewShowing = false
        tableView?.userInteractionEnabled = false
        imageView?.userInteractionEnabled = false
        guard let imageView = self.imageView else {return}
        guard let tableView = self.tableView else {return}
        
//        self.imageView!.addBlurEffect(CGFloat(0.0))
        UIView.animateWithDuration(time,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    imageView <- [
                                        Top().to(self.topLayoutGuide)
                                    ]
                                    tableView <- [
                                        Top().to(self.imageView!)
                                    ]
                                    self.view.layoutIfNeeded()
                                    self.tableView?.layoutIfNeeded()
                                    self.imageView?.layoutIfNeeded()
            },
                                   completion: { finished in
                                    
//                                    self.view.bringSubviewToFront(self.clickView!)
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

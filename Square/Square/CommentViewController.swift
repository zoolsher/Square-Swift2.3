//
//  CommentViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/9.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import IQKeyboardManager

class CommentViewController: UIViewController {

    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        _viewFrame = self.view.frame
        IQKeyboardManager.sharedManager().enable = false;
        IQKeyboardManager.sharedManager().enableAutoToolbar = false;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
        let rightButton = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CommentViewController.sendComment(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        // Do any additional setup after loading the view.
    }
    
    func sendComment(sender:AnyObject?){
        
        print("sending message")
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func keyboardShow(notification:NSNotification){
        let userinfo = notification.userInfo
        let keyboardRect = userinfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let keyboardDuration:NSTimeInterval = userinfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        
        self.moveTheSegUpWithKeyBoardHeight((keyboardRect?.height)!, withDuration: keyboardDuration)
    }
    func keyboardDisappear(notification:NSNotification){
        let userinfo = notification.userInfo
        let keyboardDuration : NSTimeInterval = userinfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        self.moveTheSegDown(keyboardDuration)
    }
    
    private var _commentTextViewFrame:CGRect? = nil;
    private var _segViewFrame:CGRect? = nil;
    private var _viewFrame : CGRect? = nil;
    func moveTheSegUpWithKeyBoardHeight(keyboardHeight:CGFloat,withDuration duration:NSTimeInterval){
//        _commentTextViewFrame = self.commentTextView.frame
//        _segViewFrame = self.segment.frame
//        _viewFrame = self.view.frame
//        var textViewFrame = self.commentTextView.frame
//        textViewFrame.size.height -= keyboardHeight;
//        var segFrame = self.segment.frame
//        segFrame.origin.y -= keyboardHeight
        var viewFrame  = _viewFrame
        viewFrame!.size.height -= keyboardHeight
        UIView.animateWithDuration(duration) {
            self.view.frame = viewFrame!
//            self.commentTextView.frame = textViewFrame
//            self.segment.frame = segFrame
        }
        
    }
    
    func moveTheSegDown(duration:NSTimeInterval){
        UIView.animateWithDuration(duration) {
//            self.commentTextView.frame = self._commentTextViewFrame!
//            self.segment.frame = self._segViewFrame!
            if let _frame = self._viewFrame{
                self.view.frame = _frame
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

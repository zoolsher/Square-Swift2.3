//
//  LoginView.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    weak var view:UIView!;
    
    var backAction : (()->())?;
    var goForwardAction : (()->Void)?;
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    @IBAction func forward(sender: UIButton) {
        if let act = goForwardAction{
            act()
        }
    }
    @IBAction func back(sender: UIButton) {
        if let act = backAction{
            act()
        }
    }
    func getUserNameAndPassword ()->(String?,String?){
        return (self.userNameTextField.text,self.passwordTextField.text);
    }
    
    func loadViewFromXib()->UIView{
        let bundle = NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options: nil);
        let tmpView = bundle?.first as! UIView;
        return tmpView;
    }
    
    func setupSubviews(){
        
        view = loadViewFromXib()
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        self.addSubview(view)
        container.frame = self.bounds
        
        
        let leftText = NSMutableAttributedString(string: "\u{e637}", attributes:
            [
                NSFontAttributeName : UIFont(name: "iconfont", size: 16)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]);
        let backText = NSMutableAttributedString(string: " back", attributes:
            [
                NSFontAttributeName : UIFont(name: "DINCOND-Regular", size:16)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]);
        leftText.appendAttributedString(backText)
        backBtn.setAttributedTitle(leftText, forState: UIControlState.Normal)
        
        let rightText = NSMutableAttributedString(string: "go", attributes:
            [
                NSFontAttributeName : UIFont(name: "DINCOND-Regular", size: 16)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]);
        let goText = NSMutableAttributedString(string: " \u{e642}", attributes:
            [
                NSFontAttributeName : UIFont(name: "iconfont", size:16)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]);
        rightText.appendAttributedString(goText)
        goBtn.setAttributedTitle(rightText, forState: UIControlState.Normal)
        
    }
    
    
    
    override func layoutSubviews() {
        view.frame = self.bounds
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame:CGRect.zero)
    }
}

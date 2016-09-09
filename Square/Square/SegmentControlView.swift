//
//  SegmentControlView.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import EasyPeasy

class SegmentControlView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var tapView: UIView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var constainsForTapView: NSLayoutConstraint!
    
    @IBOutlet weak var centerXConstrainForTapView: NSLayoutConstraint!
    
    weak var view:UIView!;
    
    var name1:String = ""{
        didSet{
            self.label1.text = name1
        }
    }
    var name2:String = ""{
        didSet{
            self.label2.text = name2
        }
    }
    var name3:String = ""{
        didSet{
            self.label3.text = name3
        }
    }
    
    private var labelArr = [UILabel]()
    var labelAction : ((Int,Int)->())? = nil
    private var tGR = [UITapGestureRecognizer]()
    private var curIndex = 1;
    func loadAction(){
        labelArr.append(label1)
        labelArr.append(label2)
        labelArr.append(label3)
        
        for i in 0..<labelArr.count {
            let tempGR = UITapGestureRecognizer(target: self, action: #selector(dispatchAction))
            labelArr[i].addGestureRecognizer(tempGR)
            labelArr[i].userInteractionEnabled = true
            tGR.append(tempGR)
        }
        
        
        
    }
    
    func dispatchAction(sender:UITapGestureRecognizer){
        if let index = tGR.indexOf(sender){
            animation(index)
            if let action = self.labelAction{
                action(curIndex,index)
            }
            curIndex = index;
        }
    }
    
    var _lastCons : NSLayoutConstraint? = nil
    func animation(index : Int){
        if _lastCons==nil {
            _lastCons = centerXConstrainForTapView
        }
        if(index == curIndex){
            return
        }else{
            UIView.animateWithDuration(0.5,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 15.0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        for label in self.labelArr {
                                            label.textColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1.00)
                                        }
                                        let label = self.labelArr[index];
                                        let width = label.frame.width;
                                        if index == 0{
                                            self.centerXConstrainForTapView.constant = CGFloat(-width)
                                        }else if(index == 1){
                                            self.centerXConstrainForTapView.constant = CGFloat(0)
                                        }else{
                                            self.centerXConstrainForTapView.constant = CGFloat(width)
                                        }
                                        self.layoutIfNeeded()
                                        label.textColor = UIColor(red:0.50, green:0.12, blue:0.13, alpha:1.00)

                },
                                       completion: nil)
        }
    }
    
    var selected : Int = 1{
        didSet{
            constainsForTapView = NSLayoutConstraint(item: constainsForTapView.firstItem, attribute: constainsForTapView.firstAttribute, relatedBy: constainsForTapView.relation, toItem: labelArr[selected], attribute: constainsForTapView.secondAttribute, multiplier: constainsForTapView.multiplier, constant: constainsForTapView.constant)
            
        }
    }
    
    func loadViewFromXib()->UIView{
        let bundle = NSBundle.mainBundle().loadNibNamed("SegmentControlView", owner: self, options: nil);
        let tmpView = bundle?.first as! UIView;
        return tmpView;
    }
    
    
    
    func setupSubviews(){
        
        view = loadViewFromXib()
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        self.addSubview(view)
        container.frame = self.bounds
        
        loadAction()
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

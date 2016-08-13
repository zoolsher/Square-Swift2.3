//
//  UserInfoProfileCollectionViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/10.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class UserInfoProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avator: UIImageView!

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subscribeLabel: UILabel!
    
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var userBackgroundImageView: UIImageView!
    
    @IBOutlet weak var listenerView: UIView!
    
    var clickAction : (()->Void)? = nil;
    func loadData(userName:String,title:String,info:String,subscribe:String,follower:String,following:String){
        self.userNameLabel.text = userName
        self.titleLabel.text = title
        self.infoLabel.text = " "+info
        self.subscribeLabel.text = subscribe
        self.followerLabel.text = follower
        self.followingLabel.text = following
    }
    
    func loadBackgroundImage(image:UIImage){
        self.userBackgroundImageView.image = image
    }
    
    func loadImage(image:UIImage){
        self.avator.image = image
    }
    
    func tapHandler(sender:UITapGestureRecognizer){
        guard let clickAction = clickAction else { return }
        clickAction();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let listener = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        
        self.listenerView.addGestureRecognizer(listener)
        // Initialization code
    }

}

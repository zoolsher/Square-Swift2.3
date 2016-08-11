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
    
    func loadData(userName:String,title:String,info:String,subscribe:String,follower:String,following:String){
        self.userNameLabel.text = userName
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.subscribeLabel.text = subscribe
        self.followerLabel.text = follower
        self.followingLabel.text = following
    }
    
    func loadImage(image:UIImage){
        self.avator.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

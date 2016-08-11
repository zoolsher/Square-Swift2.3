//
//  NotificationTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/7.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var avatorImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func loadData(name:String,action:String,time:String){
        self.nameLabel.text = name;
        self.actionLabel.text = name;
        self.timeLabel.text = time;
    }
    
    func loadImage(img:UIImage){
        self.avatorImageView.image = img;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

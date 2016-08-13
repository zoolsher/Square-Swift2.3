//
//  FolllowerTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/13.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class FolllowerTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var avator: UIImageView!
    
    func loadData(username:String,intro:String){
        self.userNameLabel.text = username
        self.introLabel.text = intro
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

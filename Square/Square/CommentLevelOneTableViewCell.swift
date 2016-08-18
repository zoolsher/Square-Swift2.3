//
//  CommentLevelOneTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/17.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class CommentLevelOneTableViewCell: UITableViewCell {

    @IBOutlet weak var avator: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    let cellReuseID = "_commentLevelOneTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

//
//  CommentLevelTwoTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/17.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import EasyPeasy

class CommentLevelTwoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aligenerView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    let reuseID = "_commentLevelTwoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView()
        self.contentView.addSubview(backgroundView)
        backgroundView <- [
            Left(-5).to(self.userNameLabel,.Left),
            Right(0).to(self.commentLabel,.Right),
            Top(0).to(self.aligenerView,.Top),
            Bottom(0).to(self.aligenerView,.Bottom)
        ]
        backgroundView.backgroundColor = UIColor.darkGrayColor()
        self.contentView.sendSubviewToBack(backgroundView)
        
        let arrow = UIView()
        self.contentView.addSubview(arrow)
        arrow <- [
            Width(10),
            Height(10),
            CenterY().to(backgroundView,.Top),
            CenterX(10).to(backgroundView,.Left)
        ]
        arrow.backgroundColor = UIColor.darkGrayColor()
        arrow.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/4)
        self.contentView.sendSubviewToBack(arrow)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

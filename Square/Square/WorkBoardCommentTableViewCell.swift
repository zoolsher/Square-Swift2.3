//
//  WorkBoardCommentTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/10.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class WorkBoardCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var avator: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var commentContentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(userName:String,userTitle:String,comment:String){
        self.userNameLabel.text = userName
        self.userTitleLabel.text = userTitle
        self.commentContentTextView.text = comment
    }
    func loadImage(img:UIImage){
        self.avator.image = img
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

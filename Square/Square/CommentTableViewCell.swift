//
//  CommentTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/7.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatorImageView: UIImageView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var commentTextview: UITextView!
    

    @IBOutlet weak var myWorkLabel: UILabel!
    
    func loadData(userName:String,time:String,comment:String,myWork:String){
        self.userNameLabel.text = userName
        self.timeLabel.text = time
        self.commentTextview.text = comment
        self.myWorkLabel.text = " "+myWork
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

//
//  CollectionTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var postByLabel: UILabel!
    
    @IBOutlet weak var collectionImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var introTextView: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    func loadData(time:String,postedBy:String,title:String,intro:String,category:String,view:String,heart:String,comment:String){
        
        self.timeLabel.text = time;
        self.postByLabel.text = postedBy;
        self.titleLabel.text = title;
        self.introTextView.text = intro;
        self.categoryLabel.text = category;
        
        
        
        
        let heartAttributedString = NSMutableAttributedString(string: "\u{e639} ", attributes: [
            NSFontAttributeName : UIFont(name: "iconfont", size: 14)!
            ])
        let commentAttributedString = NSMutableAttributedString(string: "\u{e628} ", attributes: [
            NSFontAttributeName : UIFont(name: "iconfont", size: 14)!
            ])
        let viewAttributedString = NSMutableAttributedString(string:"\u{e65d} ",attributes: [NSFontAttributeName:UIFont(name:"iconfont",size:14)!]);
        
        heartAttributedString.appendAttributedString(NSAttributedString(string: heart))
        commentAttributedString.appendAttributedString(NSAttributedString(string: comment))
        viewAttributedString.appendAttributedString(NSAttributedString(string:view));
        
        self.viewLabel.attributedText = viewAttributedString
        self.commentLabel.attributedText = commentAttributedString
        self.heartLabel.attributedText = heartAttributedString
        
        
    }
    
    func loadImage(img:UIImage){
        
        
        self.collectionImageView.image = img
        
        
        collectionImageView.contentMode = .ScaleAspectFill
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.timeLabel.text = "";
        self.postByLabel.text = "";
        self.titleLabel.text = "";
        self.introTextView.text = "";
        self.categoryLabel.text = "";
        self.viewLabel.text = "";
        self.heartLabel.text = "";
        self.commentLabel.text = "";
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

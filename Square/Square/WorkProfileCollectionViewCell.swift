//
//  WorkProfileCollectionViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/11.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class WorkProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var workImageView: UIImageView!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    func loadData(heart:String,comment:String){
        let heartAttributedString = NSMutableAttributedString(string: "\u{e639}", attributes: [
            NSFontAttributeName : UIFont(name: "iconfont", size: 14)!
            ])
        let commentAttributedString = NSMutableAttributedString(string: "\u{e628}", attributes: [
            NSFontAttributeName : UIFont(name: "iconfont", size: 14)!
            ])
        
        heartAttributedString.appendAttributedString(NSAttributedString(string: heart))
        commentAttributedString.appendAttributedString(NSAttributedString(string: comment))
        self.commentLabel.attributedText = commentAttributedString
        self.heartLabel.attributedText = heartAttributedString
    }
    
    func loadImage(image:UIImage){
    
        self.workImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

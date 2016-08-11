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
        self.commentLabel.text = comment
        self.heartLabel.text = heart
    }
    
    func loadImage(image:UIImage){
    
        self.workImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

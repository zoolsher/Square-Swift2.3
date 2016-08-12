//
//  StackProfileCollectionViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/12.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class StackProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stackImageView: UIImageView!
    
    @IBOutlet weak var stackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(text:String){
        self.stackLabel.text = text
    }
    
    func loadImage(img:UIImage){
        self.stackImageView.image = img
    }
}

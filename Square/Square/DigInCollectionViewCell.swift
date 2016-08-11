//
//  DigInCollectionViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/8.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class DigInCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stackImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(image:UIImage){
        self.stackImageView.image = image
    }

}

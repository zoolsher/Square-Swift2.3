//
//  SendingStatusCollectionViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/12.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class SendingStatusCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var label: UILabel!
    
    var text: NSAttributedString? {
        didSet {
            self.label.attributedText = self.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

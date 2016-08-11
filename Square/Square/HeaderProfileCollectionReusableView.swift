//
//  HeaderProfileCollectionReusableView.swift
//  Square
//
//  Created by zoolsher on 2016/8/11.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class HeaderProfileCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var textLabel: UILabel!
    
    func loadData(text:String){
        self.textLabel.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//
//  CWUserListCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/9/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWUserListCell: UICollectionViewCell {
    
    static let identifire = "CWUserListCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 20
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.green.cgColor
    }
    
}

//
//  CWUserListCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/9/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit
import SDWebImage

class CWUserListCell: UICollectionViewCell {
    
    static let identifier = "CWUserListCell"
    
    @IBOutlet weak private var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 20
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.green.cgColor
        /// Testing purpose
        userImageView.sd_setImage(with: URL(string: "https://gravatar.com/avatar/c572429be479f5661a39d48482b3ca24?s=400&d=robohash&r=x"), placeholderImage: UIImage(systemName: "person.circle.fill"), options: .refreshCached, context: nil)

    }
    
}

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
        userImageView.sd_setImage(with: URL(string: "https://pbs.twimg.com/media/DNUBk22W0AA1jIK.jpg"), placeholderImage: UIImage(systemName: "person.circle.fill"), options: .refreshCached, context: nil)

    }
    
}

//
//  CWImageCLCCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWImageCell: UICollectionViewCell {
    
    static let identifier = "CWImageCell"
    
    @IBOutlet weak private var titleImageView: UIImageView!
    @IBOutlet weak private var numberOfImagesLabel: UILabel!
    
    func configureCell(imageName: String, imageCounter : Int, isLastCell : Bool){
        titleImageView.image = UIImage(named: imageName)
        numberOfImagesLabel.isHidden = true
        if isLastCell && imageCounter > CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY {
            numberOfImagesLabel.isHidden = false
            numberOfImagesLabel.text = "\(imageCounter)+"
        }

    }
    
}

//
//  CWUserHeaderView.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/9/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWUserHeaderView: UICollectionReusableView {
    
    static let identifire = "CWUserHeaderView"
    
    @IBOutlet weak private var sendBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        style()
    }
    
    private func style(){
        sendBtn.layer.cornerRadius = 20
    }
    
    @IBAction func sendBtnAction(_ sender: Any) {
    }
}

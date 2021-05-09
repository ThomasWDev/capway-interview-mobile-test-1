//
//  CWImageDetailsVC.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/10/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWImageDetailsVC: UIViewController {
    
    var imageName: String?
    
    @IBOutlet weak private var titleImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleImageView.image = UIImage(named: imageName ?? "")
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  CWMultipleImageCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWMultipleImageCell: UITableViewCell {
    
    static let identifire = "CWMultipleImageCell"
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var moreBtn: UIButton!
    @IBOutlet weak private var detailsLbl: UILabel!
    @IBOutlet weak private var clcView: UICollectionView!
    @IBOutlet weak private var likeLbl: UILabel!
    @IBOutlet weak private var commentLbl: UILabel!
    @IBOutlet weak private var shareBtn: UIButton!
    @IBOutlet weak private var heartBtn: UIButton!
    @IBOutlet weak private var commentBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: DashbaordResponse){
        titleLbl.text = data.postTitle
        dateLbl.text = data.postDate
        moreBtn.isHidden = (data.isMoreBtnHide ?? false)
        detailsLbl.text = data.details
//        titleImageView.image = UIImage(named: <#T##String#>)
        likeLbl.text = "\(data.likeCount ?? 0)"
        commentLbl.text = "\(data.commentCount ?? 0)"
    }

    @IBAction func moreBtnAction(_ sender: Any) {
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
    }
    
    @IBAction func heartBtnAction(_ sender: Any) {
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
    }
}

extension CWMultipleImageCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWImageCLCCell.identifire, for: indexPath) as! CWImageCLCCell
        return cell
    }
}

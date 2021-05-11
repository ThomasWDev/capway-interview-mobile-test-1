//
//  CWNormalCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWNormalCell: UITableViewCell {
    
    static let identifier = "CWNormalCell"
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var moreBtn: UIButton!
    @IBOutlet weak private var detailsLbl: UILabel!
    @IBOutlet weak private var titleImageView: UIImageView!
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
    
    func configureCell(data: DashboardResponse){
        let post = data.postTitle ?? Post()
        titleLbl.attributedText = Helper.postAttributedTxt(post: post)
        dateLbl.text = data.postDate
        moreBtn.isHidden = (data.isMoreBtnHide ?? false)
        detailsLbl.text = data.details
        titleImageView.image = UIImage(named: data.multipleImage?.first ?? "")
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

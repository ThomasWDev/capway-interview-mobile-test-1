//
//  CWNormalCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit
import SDWebImage

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
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellWith(feed: Feed){
        titleLbl.attributedText = Helper.feedheaderAttributedString(feed: feed)
        dateLbl.text = feed.publishedAt
        detailsLbl.text = feed.description
        titleImageView.sd_setImage(with: URL(string: feed.urlToImage ?? ""), completed: nil)
        profileImageView.sd_setImage(with: URL(string: feed.avatarURL), placeholderImage: UIImage(systemName: "person.circle.fill"), options: .refreshCached, context: nil)
        likeLbl.text = "\(feed.likes)"
        commentLbl.text = "\(feed.comments)"
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

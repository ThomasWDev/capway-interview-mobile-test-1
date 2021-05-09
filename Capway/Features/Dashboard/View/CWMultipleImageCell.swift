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
    
    private var dataList: DashbaordResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clcView.delegate = self
        clcView.dataSource = self
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: DashbaordResponse){
        dataList = data
        let post = data.postTitle ?? Post()
        titleLbl.attributedText = Helper.postAttributedTxt(post: post)
        dateLbl.text = data.postDate
        moreBtn.isHidden = (data.isMoreBtnHide ?? false)
        detailsLbl.text = data.details
//        titleImageView.image = UIImage(named: <#T##String#>)
        likeLbl.text = "\(data.likeCount ?? 0)"
        commentLbl.text = "\(data.commentCount ?? 0)"
        
        clcView.reloadData()
    }

    @IBAction func moreBtnAction(_ sender: Any) {
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
    }
    
    @IBAction func heartBtnAction(_ sender: Any) {
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
    }
    
    private func setupCollectionView(){
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let inset: CGFloat = 0.5
            
            // Items
            let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
            largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.47))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Nested Group
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
            
            // Outer Group
            let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.7))
            let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
            
            // Section
            let section = NSCollectionLayoutSection(group: outerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Supplementary Item
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
            section.boundarySupplementaryItems = [headerItem]
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
        clcView.collectionViewLayout = compositionalLayout
    }
}

extension CWMultipleImageCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.multipleImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWImageCLCCell.identifire, for: indexPath) as! CWImageCLCCell
        let imageName = dataList?.multipleImage?[indexPath.row] ?? ""
        cell.configureCell(imageName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 20)/2
        return CGSize(width: width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = dataList?.multipleImage?[indexPath.row] ?? ""
        
        showImageDetails(imageName: imageName)
    }
    
    private func showImageDetails(imageName: String){
        let storyboard = UIStoryboard(storyboard: .dashboard)
        let vc = storyboard.instantiateViewController(withIdentifier: CWImageDetailsVC.self)
        vc.imageName = imageName
        let mwindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let parentVC = mwindow?.visibleViewController() else {return}
        parentVC.present(vc, animated: true, completion: nil)
    }
}

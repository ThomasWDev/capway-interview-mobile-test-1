//
//  CWDashboardVC.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit
import IDMPhotoBrowser
import SVProgressHUD

class CWDashboardVC: UIViewController {
    
    @IBOutlet weak private var searchView: UIView!
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet weak private var userListClcView: UICollectionView!
    private let networkManager = NetworkManager()
    private var photoRepository : FeedRepository?
    private var feeds : [Feed] = [] {
        didSet {
            /// Hardcoded testing
            var multipleFeed = Feed(author: "Thomas Woodfin", title: "Testing multiple images", urlToImage: "https://robohash.org/cc367b7dce35acdd3b4c6453cb392c0b?set=set4&bgset=&size=400x400", description: "", publishedAt: "2021-05-11T16:49:00Z")
            multipleFeed.images = ["ic_dummy_img_3", "ic_dummy_img_4", "ic_dummy_img_5", "ic_dummy_img_6", "ic_dummy_img_8"]
            feeds.append(multipleFeed)
            self.tblView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFeeds()
        style()
    }

    private func fetchFeeds() {
        SVProgressHUD.show()
        photoRepository = FeedRepository(networkManager: networkManager)
        photoRepository?.fetchFeeds(completion: { (result) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                switch result {
                case .success(let feeds): self.feeds = feeds
                case .failure(let error): debugPrint(error.localizedDescription)
                }
            }
        })
    }

    private func showAlert(_ message : String) {
        let alert = UIAlertController(title: "Capway", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func style(){
        self.navigationController?.navigationBar.isHidden = true
        searchView.layer.cornerRadius = 20
        userListClcView.delegate = self
        userListClcView.dataSource = self
        tblView.tableFooterView = UIView()
    }
}

extension CWDashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = feeds[indexPath.row]
        
        if feed.isMultipleImages {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: CWMultipleImageCell.identifier, for: indexPath) as! CWMultipleImageCell
            cell2.selectionStyle = .none
            cell2.configureCellWith(feed: feed)
            return cell2
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CWNormalCell.identifier, for: indexPath) as! CWNormalCell
            cell.selectionStyle = .none
            cell.configureCellWith(feed: feed)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = feeds[indexPath.row]
        if !feed.isMultipleImages {
            if let url = URL(string: feed.urlToImage ?? "") {
                prevPhotos(photos: [IDMPhoto(url: url)])
            }
        } else {
            prevPhotos(photos: feed.images.map{ IDMPhoto(image: (UIImage(named: $0) ?? UIImage()))})
        }
    }

    private func prevPhotos(photos: [IDMPhoto]){

        let photosVC = IDMPhotoBrowser(photos: photos)
        self.present(photosVC!, animated: true, completion: nil)
    }
}


extension CWDashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWUserListCell.identifier, for: indexPath) as! CWUserListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CWUserHeaderView.identifier, for: indexPath) as! CWUserHeaderView
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

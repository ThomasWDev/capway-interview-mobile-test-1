//
//  CWDashboardVC.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWDashboardVC: UIViewController {
    
    @IBOutlet weak private var searchView: UIView!
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet weak private var userListClcView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    private func style(){
        self.navigationController?.navigationBar.isHidden = true
        searchView.layer.cornerRadius = 20
        userListClcView.delegate = self
        userListClcView.dataSource = self
    }
}

extension CWDashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.dummyDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Constants.dummyDataArr[indexPath.row]
        
        if model.multipleImage?.count ?? 0 > 1{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: CWMultipleImageCell.identifire, for: indexPath) as! CWMultipleImageCell
            cell2.selectionStyle = .none
            cell2.configureCell(data: model)
            return cell2
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CWNormalCell.identifire, for: indexPath) as! CWNormalCell
            cell.selectionStyle = .none
            cell.configureCell(data: model)
            return cell
        }
    }
    
    
}


extension CWDashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWUserListCell.identifire, for: indexPath) as! CWUserListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CWUserHeaderView.identifire, for: indexPath) as! CWUserHeaderView
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

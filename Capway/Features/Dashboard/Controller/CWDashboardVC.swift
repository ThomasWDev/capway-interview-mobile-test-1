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
    
    private let viewModel = CWDashboardVM()
    
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
        if viewModel.dummyDataArr.count == 0{
            Helper.emptyMessageInTableView(tableView, "No data available")
        }else{
            tableView.backgroundView = nil
        }
        return viewModel.dummyDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dummyDataArr[indexPath.row]
        
        if model.multipleImage?.count ?? 0 > 1{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: CWMultipleImageCell.identifier, for: indexPath) as! CWMultipleImageCell
            cell2.selectionStyle = .none
            cell2.configureCell(data: model)
            return cell2
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CWNormalCell.identifier, for: indexPath) as! CWNormalCell
            cell.selectionStyle = .none
            cell.configureCell(data: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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

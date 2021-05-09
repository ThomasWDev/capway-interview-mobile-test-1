//
//  CWDashboardVC.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWDashboardVC: UIViewController {
    
    @IBOutlet weak private var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            cell2.configureCell(data: model)
            return cell2
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CWNormalCell.identifire, for: indexPath) as! CWNormalCell
            cell.configureCell(data: model)
            return cell
        }
    }
    
    
}

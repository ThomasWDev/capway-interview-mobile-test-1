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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWNormalCell.identifire, for: indexPath) as! CWNormalCell
        
        return cell
    }
    
    
}

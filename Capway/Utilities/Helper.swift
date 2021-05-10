//
//  Helper.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

struct Helper{
    
    static func emptyMessageInCollectionView(_ collectionView: UICollectionView,_ title: String){
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        noDataLabel.textColor        = .lightGray
        noDataLabel.font             = UIFont(name: "Open Sans", size: 15)
        noDataLabel.textAlignment    = .center
        collectionView.backgroundView = noDataLabel
        noDataLabel.text = title
    }
    
    static func emptyMessageInTableView(_ tableView: UITableView,_ title: String){
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.textColor        = UIColor(red: 67, green: 67, blue: 67, alpha: 1)
        noDataLabel.font             = UIFont(name: "Open Sans", size: 15)
        noDataLabel.textAlignment    = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        noDataLabel.text = title
    }
    
    static func postAttributedTxt(post: Post)-> NSAttributedString{
        let authorName = post.authorName ?? ""
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let authorNameString = NSMutableAttributedString(string: authorName, attributes:attrs)
        
        let detailsText = post.details ?? ""
        
        if detailsText.isEmpty{
            return authorNameString
        }
        
        let detailsString = NSMutableAttributedString(string: detailsText)
        
        let albumName = post.albumName ?? ""
        let albumNameString = NSMutableAttributedString(string: albumName, attributes:attrs)

        detailsString.append(albumNameString)
        authorNameString.append(detailsString)
        
        return authorNameString
    }

}

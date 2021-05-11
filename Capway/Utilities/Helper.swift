//
//  Helper.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

struct Helper {
    
    static func feedheaderAttributedString(feed: Feed)-> NSAttributedString{
        let authorName = feed.author ?? ""
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let authorNameString = NSMutableAttributedString(string: authorName, attributes:attrs)
        
        let detailsText = " \(feed.title ?? "")"
        
        if detailsText.isEmpty{
            return authorNameString
        }
        
        let detailsString = NSMutableAttributedString(string: detailsText)

        authorNameString.append(detailsString)
        
        return authorNameString
    }

}

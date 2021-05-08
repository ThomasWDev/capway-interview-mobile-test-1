//
//  Constants.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

struct Constants {
    static let noInternet = "Internet is not available. Please check your network connectivity"
    
    static let dummyDataArr = [DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: "Bill Roalling added 10 new photos in album \("Travel")", postDate: "", isMoreBtnHide: true, details: "", isDetailsLblHide: true, likeCount: 104, commentCount: 0, multipleImage: ["ic_dummy_img_1"], isMultipleImageHide: true),
    
        DashbaordResponse(imageName: "ic_dummy_pro_2", postTitle: "Bill Roalling", postDate: "24 March . 4:00 PM", isMoreBtnHide: false, details: "Look at this. The awesome animation!", isDetailsLblHide: false, likeCount: 64, commentCount: 10, multipleImage: ["ic_dummy_img_2"], isMultipleImageHide: true),
    
    
        DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: "Bill Roalling added 5 new photos in album \("ABC")", postDate: "", isMoreBtnHide: true, details: "ABC is love", isDetailsLblHide: false, likeCount: 33, commentCount: 10, multipleImage: ["ic_dummy_img_1", "ic_dummy_img_2", "ic_dummy_img_3"], isMultipleImageHide: false)]
}


struct DashbaordResponse{
    var imageName: String?
    var postTitle: String?
    var postDate: String?
    var isMoreBtnHide: Bool?
    var details: String?
    var isDetailsLblHide: Bool?
    var likeCount: Int?
    var commentCount: Int?
    var multipleImage: [String]?
    var isMultipleImageHide: Bool?
}

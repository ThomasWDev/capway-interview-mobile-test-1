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
    
    static let dummyDataArr = [DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: Post(authorName: "Bill Roalling", details: " added 10 new photos in album", albumName: " \("Travel")"), postDate: "", isMoreBtnHide: true, details: "", isDetailsLblHide: true, likeCount: 104, commentCount: 0, multipleImage: ["ic_dummy_img_1"], isMultipleImageHide: true),
    
        DashbaordResponse(imageName: "ic_dummy_pro_2", postTitle: Post(authorName: "Bill Roalling", details: "", albumName: ""), postDate: "24 March . 4:00 PM", isMoreBtnHide: false, details: "Look at this. The awesome animation!", isDetailsLblHide: false, likeCount: 64, commentCount: 16, multipleImage: ["ic_dummy_img_2"], isMultipleImageHide: true),
    
    
        DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: Post(authorName: "Bill Roalling", details: " added 5 new photos in album", albumName: " \("ABC")"), postDate: "", isMoreBtnHide: true, details: "ABC is love", isDetailsLblHide: false, likeCount: 33, commentCount: 10, multipleImage: ["ic_dummy_img_3", "ic_dummy_img_4", "ic_dummy_img_5", "ic_dummy_img_6"], isMultipleImageHide: false),
        
        
        DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: Post(authorName: "Bill Roalling", details: " added 4 new photos in album", albumName: " \("Travel")"), postDate: "", isMoreBtnHide: true, details: "", isDetailsLblHide: true, likeCount: 64, commentCount: 0, multipleImage: ["ic_dummy_img_8"], isMultipleImageHide: true),
    
        DashbaordResponse(imageName: "ic_dummy_pro_1", postTitle: Post(authorName: "Bill Roalling", details: " added 5 new photos in album", albumName: " \("ABC")"), postDate: "", isMoreBtnHide: true, details: "ABC is love", isDetailsLblHide: false, likeCount: 33, commentCount: 10, multipleImage: ["ic_dummy_img_7", "ic_dummy_img_8", "ic_dummy_img_9", "ic_dummy_img_1"], isMultipleImageHide: false)]
}


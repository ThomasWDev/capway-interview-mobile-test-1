//
//  DashbaordResponse.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/10/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

struct DashboardResponse{
    var imageName: String?
    var postTitle: Post?
    var postDate: String?
    var isMoreBtnHide: Bool?
    var details: String?
    var isDetailsLblHide: Bool?
    var likeCount: Int?
    var commentCount: Int?
    var multipleImage: [String]?
    var isMultipleImageHide: Bool?
}

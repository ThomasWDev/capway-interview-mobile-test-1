//
//  URLPaths.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation



#if DEVELOPMENT
let KBasePath = "https://hoopla-ws.hoopladigital.com"
#else
let KBasePath = "https://hoopla-ws.hoopladigital.com"
#endif

enum OauthPath: String {
    case getMovideList              = "/kinds/7/titles/top"
    case getMovideDetails           = "/titles/"
}

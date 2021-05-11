//
//  DataResponse.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

struct DataResponse<T> {
    
    let data: T?
    let urlResponse: URLResponse?
    
    init(data: T?, urlResponse: URLResponse?) {
        self.data = data
        self.urlResponse = urlResponse
    }
}

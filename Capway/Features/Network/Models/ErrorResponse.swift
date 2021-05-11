//
//  ErrorResponse.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

struct ErrorResponse {
    
    let data: Data?
    let urlResponse: URLResponse?
    var statusCode: Int? {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            return nil
        }
        return httpURLResponse.statusCode
    }
    
    init(data: Data?, urlResponse: URLResponse?) {
        self.data = data
        self.urlResponse = urlResponse
    }
}

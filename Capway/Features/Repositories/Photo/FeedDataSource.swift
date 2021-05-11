//
//  FeedDataSource.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

typealias FeedDataSourceCompletion = (Result<[Feed], Error>) -> Void

protocol FeedDataSource {
    
    func fetchFeeds(completion: FeedDataSourceCompletion?)
}

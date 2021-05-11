//
//  FeedRepository.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

typealias FeedRepositoryCompletion = (Result<[Feed], Error>) -> Void

class FeedRepository {
    
    var networkDataSource: FeedNetworkDataSource
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        networkDataSource = FeedNetworkDataSource(networkManager: networkManager)
    }
    
    func fetchFeeds(completion: FeedRepositoryCompletion?) {
        networkDataSource.fetchFeeds() { result in
            switch result {
            case .success(let items):
                completion?(.success(items))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}

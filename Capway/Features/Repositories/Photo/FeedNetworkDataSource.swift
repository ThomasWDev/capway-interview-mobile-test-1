//
//  FeedNetworkDataSource.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

class FeedNetworkDataSource: FeedDataSource {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchFeeds(completion: FeedDataSourceCompletion?) {
        let requestConfiguration = RequestConfiguration(endpoint: "https://newsapi.org/v2/everything?q=tesla&from=2021-04-17&sortBy=publishedAt&apiKey=2ab0a50547d748dca7d11eeafa9b638d", httpMethod: .get, parameters: nil)
        networkManager.executeRequest(requestConfiguration: requestConfiguration, responseModel: NewsFeed.self) { result in
            switch result {
            case .success(let dataResponse):
                if let newsFeed = dataResponse.data as? NewsFeed {
                    completion?(.success(newsFeed.articles))
                } else {
                    completion?(.success([]))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}

//
//  Feed.swift
//
//  Created by Thomas Woodfin on 5/11/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {

    let status: String?
    var totalResults: Int = 0
    var articles: [Feed] = []
}

struct Feed: Codable {

    let author: String?
    let title: String?
    let urlToImage: String?
    let description: String?
    let publishedAt: String?
    var images : [String] = []
    var likes: Int = 10
    var comments: Int = 20
    /// Dummy
    var avatarURL : String = "https://gravatar.com/avatar/cc367b7dce35acdd3b4c6453cb392c0b?s=400&d=robohash&r=x"
    var isMultipleImages : Bool {
        return images.count > 0
    }

    private enum CodingKeys: String, CodingKey {
            case author, title, urlToImage, description, publishedAt
        }
}

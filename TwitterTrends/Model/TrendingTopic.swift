//
//  TrendingTopic.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import Foundation

/**
 This structure represents a JSON response for Twitter Trending Topics.
 */
struct TrendingTopic: Codable {
    
    var trends: [Trend]
    
    struct Trend: Codable {
        var name: String
        var url: URL
        var promotedContent: String?
        var query: String?
        var tweetVolume: Int?
        
        /** Custom key mapping to get rid of the underscore. */
        enum CodingKeys: String, CodingKey {
            case name
            case url
            case promotedContent = "promoted_content"
            case query
            case tweetVolume = "tweet_volume"
        }
    }
}

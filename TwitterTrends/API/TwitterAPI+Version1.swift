//
//  TwitterAPI+Version1.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import Foundation

extension API {
    
    /**
     Fetches Twitter Trending Topics.
     
     - parameters:
         - bearerToken: The bearer token to authenticate the request.
         - completion: Completion block with trends or an error.
         - trends: Decoded Twitter Trends from JSON API in Swift struct
         - error: Optional error on failure, nil on success.
     */
    func fetchTrends(bearerToken: String, completion: @escaping (_ trends: [TrendingTopic.Trend], _ error: TwitterAPIError?) -> Void) {
        let url = URL(string: Config.API.URL.trends.rawValue)!
        var request = URLRequest(url: url)
        let authField = Config.HTTP.Fields.bearerPrefix.rawValue + bearerToken
        request.setValue(authField, forHTTPHeaderField: Config.HTTP.Fields.auth.rawValue)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion([], .generic)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion([], .wrongStatusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                let trendingTopics = try decoder.decode([TrendingTopic].self, from: data)
                guard let topic = trendingTopics.first else {
                    completion([], .serializationFailure)
                    return
                }
                completion(topic.trends, nil)
            } catch {
                completion([], .serializationFailure)
            }
        }
        
        task.resume()
    }
}

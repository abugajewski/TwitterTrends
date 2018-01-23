//
//  TwitterAPI.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import UIKit

class TwitterAPI: API {
    
    func fetchBearerToken(authString: String, completion: @escaping (String, TwitterAPIError?) -> Void) {
        let url = URL(string: Config.API.URL.token.rawValue)!
        var request = URLRequest(url: url)
        let authField = Config.HTTP.Fields.basicPrefix.rawValue + authString
        request.setValue(authField, forHTTPHeaderField: Config.HTTP.Fields.auth.rawValue)
        request.setValue(Config.HTTP.Data.contentType.rawValue, forHTTPHeaderField: Config.HTTP.Fields.contentType.rawValue)
        request.httpMethod = "POST"
        let postString = Config.HTTP.Data.grantType.rawValue
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion("", .generic)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion("", .wrongStatusCode)
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, String>
                guard let bearerToken = responseObject?[Config.API.Response.Keys.accessToken.rawValue] else {
                    completion("", .serializationFailure)
                    return
                }
                completion(bearerToken, nil)
            } catch {
                completion("", .serializationFailure)
            }
        }
        task.resume()
    }
}

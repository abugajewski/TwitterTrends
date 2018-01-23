//
//  Config.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import Foundation

/**
 Global configuration structure for app-wide variables.
 */
struct Config {
    
    /**
     All API-related configuration.
     */
    struct API {
        
        enum Auth: String {
            case consumerKey = "hFKh3MFidmqAC6jCujOA"
            case consumerSecret = "bG9frcLlDCeFDCruL8vce9LVZ571gZ0RdLd6qfkFO5w"
        }
        
        enum URL: String {
            case token = "https://api.twitter.com/oauth2/token"
            case trends = "https://api.twitter.com/1.1/trends/place.json?id=1"
        }
        
        struct Response {
            
            enum Keys: String {
                case accessToken = "access_token"
            }
        }
    }
    
    struct HTTP {
        
        /**
         HTTP Header.
         */
        enum Fields: String {
            case auth = "Authorization"
            case contentType = "Content-Type"
            case basicPrefix = "Basic "
            case bearerPrefix = "Bearer "            
        }
        
        /**
         HTTP Body.
         */
        enum Data: String {
            case grantType = "grant_type=client_credentials"
            case contentType = "application/x-www-form-urlencoded;charset=UTF-8"
        }
    }
}

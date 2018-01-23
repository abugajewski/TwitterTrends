//
//  API.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import Foundation

enum TwitterAPIError: Error {
    case generic
    case wrongStatusCode
    case serializationFailure
}

/** Generic API communication (authentication). */
protocol API {
    
    /**
     Fetches bearer token for authentication of subsequent requests.
     
     - parameters:
        - authString: The authentication string.
        - completion: Completion block with the result or an error.
        - token: Bearer token on success, empty string on failure.
        - error: Optional error on failure, nil on success.
     */
    func fetchBearerToken(authString: String, completion: @escaping (_ token: String, _ error: TwitterAPIError?) -> Void)
}

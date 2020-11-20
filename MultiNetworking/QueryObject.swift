//
//  QueryObject.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

enum UserType : String {
    case git, dailyMotion
    
    var endpoint:String {
        switch self {
        case .git:
            return Constants.gitHubUsersEndpoint
        case .dailyMotion:
            return Constants.dailyMotionEndpoint
        }
    }
}

class QueryObject {
    
    var requestType:UserType
    var parameters: [String : String]?
    var headers: [String : String]?
    
    internal init(requestType: UserType, parameters: [String : String]? = nil, headers: [String : String]? = nil) {
        self.requestType = requestType
        self.parameters = parameters
        self.headers = headers
        
    }
    
}

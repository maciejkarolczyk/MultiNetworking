//
//  QueryObject.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

public enum UserType : String {
    case git, dailyMotion
    
    var endpoint:String {
        switch self {
        case .git:
            return NetworkConstants.gitHubUsersEndpoint
        case .dailyMotion:
            return NetworkConstants.dailyMotionEndpoint
        }
    }
}

public class QueryObject {
    
    var requestType:UserType
    var parameters: [String : String]?
    var headers: [String : String]?
    
    public init(requestType: UserType, parameters: [String : String]? = nil, headers: [String : String]? = nil) {
        self.requestType = requestType
        self.parameters = parameters
        self.headers = headers
        
    }
    
}

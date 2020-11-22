//
//  Constants.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

struct NetworkConstants {
    
    // MARK: - Error Messages
    static let parsingError = "Unable to parse the response in given type"
    static let genericError = "Something went wrong. Please try again later"
    static let noConnectionError = "Not connected to Internet"
    
    // MARK: - Endpoints
    static let dailyMotionEndpoint = "https://api.dailymotion.com/users?fields=avatar_360_url,username"
    static let gitHubUsersEndpoint = "https://api.github.com/users"
}

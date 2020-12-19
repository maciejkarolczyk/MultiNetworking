//
//  Constants.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

struct NetworkConstants {
    
    // MARK: - Error Messages
    static let noBodyError = "Response from the server has no body"
    static let parsingError = "Unable to parse the response in given type"
    static let noConnectionError = "Not connected to Internet"
    static let incorrectUrlStringError = "Incorrect URL String"
    
    // MARK: - Endpoints
    static let dailyMotionEndpoint = "https://api.dailymotion.com/users?fields=avatar_360_url,username"
    static let gitHubUsersEndpoint = "https://api.github.com/users"
}

//
//  QueryObject.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

class QueryObject {

    var url: String
    var parameters: [String : String]?
    var headers: [String : String]?
    
    internal init(url: String, parameters: [String : String]? = nil, headers: [String : String]? = nil) {
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }
    
}

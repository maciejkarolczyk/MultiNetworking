//
//  QueryObject.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

class QueryObject<T> {

    var modelType = T.Type.self
    var url: String
    var parameters: [String : String]?
    var headers: [String : String]?
    
    internal init(modelType: T, url: String, parameters: [String : String]? = nil, headers: [String : String]? = nil) {
        self.modelType = T.Type.self
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }
    
}

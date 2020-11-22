//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

public class MultiNetworkingManager {
    
    public init() {}
    
    public func requestMultipleEndpoints<T:Decodable, A:Decodable>(queryItems:[QueryObject], completion: @escaping ((T?,A?,String?) -> Void)) {
        
        var resultOne: T?
        var resultTwo: A?
        var error: String?
        
        let operationQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            
            for query in queryItems {
                group.enter()
                switch query.requestType {
                case .git:
                    self.getData(queryObject: query) { (response:T) in
                        resultOne = response
                        group.leave()
                    } failureHandler: { errorString in
                        error = errorString
                        group.leave()
                    }
                case .dailyMotion:
                    self.getData(queryObject: query) { (response:A) in
                        resultTwo = response
                        group.leave()
                    } failureHandler: { errorString in
                        error = errorString
                        group.leave()
                    }
                }
            }
            group.wait()
            
        }
        let operation2 = BlockOperation {
            completion(resultOne, resultTwo, error)
        }
        operation2.addDependency(operation1)
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
    
    public func getData<T:Decodable>(queryObject:QueryObject, successHandler: @escaping (T) -> Void, failureHandler: @escaping (String) -> Void) {
        NetworkLayer.getData(urlString: queryObject.requestType.endpoint, parameters: queryObject.parameters, headers: queryObject.headers) { (response:T) in
            successHandler(response)
        } errorHandler: { errorString in
            failureHandler(errorString)
        }
    }
}

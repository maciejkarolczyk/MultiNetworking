//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

public class MultiNetworkingManager {
    
    public init() {}
    
    public func requestMultipleEndpoints(queryItems:[QueryObject], completion: @escaping (([UserType:Data],String?) -> Void)) {
        
        var results:[UserType:Data] = [:]
        var error: String?
        
        let operationQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            
            for query in queryItems {
                group.enter()
                self.getData(queryObject: query, successHandler: { (response) in
                    results[query.requestType] = response
                    group.leave()
                }) { errorString in
                    error = errorString
                    group.leave()
                }
            }
            group.wait()
            
        }
        let operation2 = BlockOperation {
            completion(results, error)
        }
        operation2.addDependency(operation1)
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
    
    public func getData(queryObject:QueryObject, successHandler: @escaping (Data) -> Void, failureHandler: @escaping (String) -> Void) {
        NetworkLayer.getData(urlString: queryObject.requestType.endpoint, parameters: queryObject.parameters, headers: queryObject.headers) { response in
            successHandler(response)
        } errorHandler: { errorString in
            failureHandler(errorString)
        }
    }
}

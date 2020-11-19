//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

class MultiNetworking {
    
    static func requestMultipleEndpoints<T:Decodable, A:Decodable>(queryOne:QueryObject, queryTwo:QueryObject, completion: @escaping ((T,A) -> Void), errorBlock : @escaping (String) -> Void) {
        
        var resultOne: T?
        var resultTwo: A?
        
        let operationQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            
            group.enter()
            NetworkLayer.getData(urlString: queryOne.url, parameters: queryOne.parameters, headers: queryOne.headers) { (response:T) in
                resultOne = response
                group.leave()
            } errorHandler: { errorString in
                group.leave()
            }
            
            group.enter()
            NetworkLayer.getData(urlString: queryTwo.url, parameters: queryTwo.parameters, headers: queryTwo.headers) { (response:A) in
                resultTwo = response
                group.leave()
            } errorHandler: { errorString in
                group.leave()
            }
            group.wait()
            
        }
        let operation2 = BlockOperation {
            completion(resultOne!, resultTwo!)
            
        }
        operation2.addDependency(operation1)
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
    
    private static func getData<T:Decodable>(queryObject:QueryObject, successHandler: @escaping (T) -> Void, failureHandler: @escaping (String) -> Void) {
        NetworkLayer.getData(urlString: queryObject.url, parameters: queryObject.parameters, headers: queryObject.headers) { (response:T) in
            successHandler(response)
        } errorHandler: { errorString in
            failureHandler(errorString)
        }
    }
}

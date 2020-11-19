//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

class MultiNetworking {
    
    func requestMultipleEndpoints<T:Decodable, A:Decodable>(queryOne:QueryObject<T>, queryTwo:QueryObject<A>, completion: @escaping (([T],[A]) -> Void)) {
        
        var resultOne: [T] = []
        var resultTwo: [A] = []
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            
            group.enter()
            NetworkLayer.getData(urlString: queryOne.url, parameters: queryOne.parameters, headers: queryOne.headers) { (response:T) in
                print(response)
                resultOne.append(response)
                group.leave()
            } errorHandler: { errorString in
                print(errorString)
                group.leave()
            }
            
            group.enter()
            NetworkLayer.getData(urlString: queryTwo.url, parameters: queryTwo.parameters, headers: queryTwo.headers) { (response:A) in
                print(response)
                resultTwo.append(response)
                group.leave()
            } errorHandler: { errorString in
                print(errorString)
                group.leave()
            }
            group.wait()
            
        }
        let operation2 = BlockOperation {
            print(resultOne)
            print(resultTwo)
            completion(resultOne,resultTwo)
        }
        operation2.addDependency(operation1)
    }
}

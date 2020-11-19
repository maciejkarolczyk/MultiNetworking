//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

class MultiNetworking {
    
    func requestMultipleEndpoints(queryObjects:[QueryObject]) {
        
        var result:[Data] = []
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            
            for query in queryObjects {
                group.enter()
                NetworkLayer.getData(urlString: query.url, parameters: query.parameters, headers: query.headers) { data in
                    result.append(data)
                    group.leave()
                } errorHandler: { errorString in
                    print(errorString)
                    group.leave()
                }
            }
            print(result)
            group.wait()
            
        }
        let operation2 = BlockOperation {
            print("done")
        }
        operation2.addDependency(operation1)
    }
}

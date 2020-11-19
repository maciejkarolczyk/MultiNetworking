//
//  MultiNetworking.swift
//  MultiNetworking
//
//  Created by Karolczyk, Maciej on 19/11/2020.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class NetworkLayer {
    
    static func getData(urlString: String,
                               parameters: [String : String]? = [:],
                               headers: [String : String]? = [:],
                               successHandler: @escaping (Data) -> Void,
                               errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(Constants.genericError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response")
                    return errorHandler("Unable to parse the response")
                }
                    successHandler(data)
                    return
            }
            errorHandler(Constants.genericError)
        }
        
        var components = URLComponents(string: urlString)!
        if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        var request = URLRequest(url: components.url!)
        
        request.allHTTPHeaderFields = headers
        
        if InternetConnectionManager.isConnectedToNetwork() {
            URLSession.shared.dataTask(with: request,
                                       completionHandler: completionHandler)
                .resume()
        } else {
            errorHandler(Constants.noConnectionError)
        }
        
    }
    
    static private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    static private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}

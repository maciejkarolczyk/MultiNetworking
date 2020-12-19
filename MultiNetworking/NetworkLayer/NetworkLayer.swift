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
                errorHandler(error.localizedDescription)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    return errorHandler(NetworkConstants.noBodyError)
                }
                successHandler(data)
                return
            }
            if let urlResponse = urlResponse {
                errorHandler(urlResponse.description)
            }
        }
        
        var components = URLComponents(string: urlString)
        if let parameters = parameters {
            components?.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        if let components = components, let url = components.url {
            var request = URLRequest(url: url)
            
            request.allHTTPHeaderFields = headers
            if (InternetConnectionManager.isConnectedToNetwork()) {
                URLSession.shared.dataTask(with: request,
                                           completionHandler: completionHandler)
                    .resume()
            } else {
                errorHandler(NetworkConstants.noConnectionError)
            }
        } else {
            errorHandler(NetworkConstants.incorrectUrlStringError)
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

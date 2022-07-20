//
//  BookEndpoint.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 10/07/2565 BE.
//

import Foundation
import Alamofire

enum BookEndpoint: URLConvertible {
    
    case overview
    case listName(listNameEncoded: String)
    
    private var baseURL: String {
        return Constant.baseURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url : URL {
        let urlComponents = NSURLComponents(string: baseURL.appending(apiPath))
        
        if urlComponents?.queryItems == nil {
            urlComponents?.queryItems = []
        }
        urlComponents?.queryItems?.append(contentsOf: [URLQueryItem(name: "api-key", value: Constant.apiKey)])

        return urlComponents!.url!
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    var apiPath : String {
        switch self {
        case .overview:
            return "overview.json"
        case .listName(let listNameEncoded):
            return "current/\(listNameEncoded).json"
            
        }
    }
}

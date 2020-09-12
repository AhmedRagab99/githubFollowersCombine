//
//  Api.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/9/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire
import Combine


enum ApiError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case AuthError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "cheack the Fields again"
        case .noData: return "please try agian later"
        case .AuthError: return "forbidden! please log in"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
 var cansels:Set<AnyCancellable> = []
class Api{
    
    
    
  
static func fetch<T:Decodable>(url:String,completion:@escaping (Result<T,ApiError>)->Void){
    
    guard let url = URL(string: url) else {
        completion(.failure(ApiError.apiError))
        return
    }
    AF.request(url)
    .validate()
       .publishDecodable(type:T.self,decoder: JSONDecoder())
    
        .sink { (responce) in
            switch responce.result{
            case .success(let results):
                completion(.success(results))
            case .failure:
                completion(.failure(ApiError.invalidResponse))
            }
    }
  .store(in: &cansels)

}
}

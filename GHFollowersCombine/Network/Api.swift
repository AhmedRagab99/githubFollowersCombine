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

var cansels:Set<AnyCancellable> = []
func fetch<T:Decodable>(url:URL,completion:@escaping (Result<T,Error>)->Void){
    AF.request(url)
       .publishDecodable(type:T.self,decoder: JSONDecoder())
        .sink { (responce) in
            switch responce.result{
            case .success(let results):
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
            
    }
  .store(in: &cancels)

}

//
//  UserInfoViewModel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/16/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Combine


class UserInfoViewModel{
    var lodingState = CurrentValueSubject<Bool,Never>(true)
    var userInfo = PassthroughSubject<User,ApiError>()
    
    
    
    func getUserData(userName:String){
        let url = ("\(BASEURL)users/\(userName)")
        
        Api.fetch(url: url) { [weak self](result:Result<User,ApiError>) in
                   guard let self = self else {return}
                   self.lodingState.send(true)
                   switch result{
                   case .success(let data):
                   
                       self.userInfo.send(data)
                       self.lodingState.send( false)

                      // print(data.count)
                   case .failure(let error):
                       self.lodingState.send( false)
                       self.userInfo.send(completion: .failure(error))
                   }
               }
    }
}

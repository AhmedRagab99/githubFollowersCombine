//
//  LoginFormViewModel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Combine
import Foundation
import Alamofire


class LoginFormViewModel {
    
    @Published var userName:String = ""
    @Published var password:String = ""
    @Published var confirmPassword:String = ""
    var userFollowers = PassthroughSubject<[UserModel],Error>()
    
    
    
    
    var  validateUserName:AnyPublisher<Bool,Never>{
        return $userName
            .map{$0.count >= 3 && !$0.contains("test example for validation") && !$0.isEmpty}
            .eraseToAnyPublisher()
        }
    
    var validatePassword:AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest($password,$confirmPassword)
            .map{ password,confirmPassword ->Bool in
                guard password == confirmPassword , password.count >= 4 else {return false}
                guard password.isEmpty == false , confirmPassword.isEmpty == false else {return false}
                return true
        }
      .eraseToAnyPublisher()
    }
    
    
    var validateCredintials:AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest(validateUserName,validatePassword)
            .map{userName,password->Bool in
                return userName && password
        }
    .eraseToAnyPublisher()
    }
    
    func fetchUser(){
       let url = URL(string: "\(BASEURL)users/\(userName)/followers")!
      
        fetch(url: url) { (result:Result<[UserModel],Error>) in
            switch result{
            case .success(let data):
                self.userFollowers.send(data)
            
            case .failure(let error):
                self.userFollowers.send(completion: .failure(error))
        }
    }
    
    
}
}


//
//  LoginFormViewModel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Combine
import Foundation


class LoginFormViewModel {
    
    @Published var userName:String = ""
    @Published var password:String = ""
    @Published var confirmPassword:String = ""
    
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
 
}


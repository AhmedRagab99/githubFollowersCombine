//
//  FavoritesViewModel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/19/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Combine

class FavoritesViewModel{
    
    let UserViewModel = UserInfoViewModel()
    var lodingState = CurrentValueSubject<Bool,Never>(true)
    var isAlertState = CurrentValueSubject<Bool,Never>(true)
    var successState = CurrentValueSubject<Bool,Never>(false)
    var errorSubject = PassthroughSubject<ApiError,Never>()
    var favorites = PassthroughSubject<[Follower],Never>()
    
    func getFavoritesList(){
        persestanceManger.retriveFavorites {[weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.favorites.send(data)
            case .failure(_):
                break
            }
        }
    }
    
    
    func getUserInfo(userName:String){
        
        let url = ("\(BASEURL)users/\(userName)")
        
        Api.fetch(url: url) { [weak self](result:Result<User,ApiError>) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                let favorite = Follower(login: data.login, avatarUrl: data.avatarUrl)
                persestanceManger.updateWith(favorite: favorite, actionType: .add) { [weak self](error) in
                    guard let self = self else {return}
                    if error == .noData{
                        self.isAlertState.value = true
                        self.successState.value = false
                        self.errorSubject.send(.noData)
                        self.errorSubject.send(error!)
                        
                    }
                    else if error == nil {
                        self.isAlertState.value = true
                        self.successState.value = true
                        self.errorSubject.send(.AuthError)
                    }
                }
            case .failure(let error):
                self.successState.value = false
                self.errorSubject.send(error)
            }
        }
    }
}

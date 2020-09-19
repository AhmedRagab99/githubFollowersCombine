//
//  FollowerListViewModel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Combine
import Foundation

class FollowersListViewModel{
    
    var userFollowers = PassthroughSubject<[Follower],ApiError>()
    var lodingState = CurrentValueSubject<Bool,Never>(true)
    var loadMore = PassthroughSubject<Bool,Never>()
    var isSearched = CurrentValueSubject<Bool,Never>(false)
    
    
    func getFollowers(userName:String,page:Int = 1){
        let url = ("\(BASEURL)users/\(userName)/followers?per_page=100&page=\(page)")
        
        Api.fetch(url: url) { [weak self](result:Result<[Follower],ApiError>) in
            guard let self = self else {return}
            self.lodingState.send(true)
            switch result{
            case .success(let data):
                
                if data.count < 100 { self.loadMore.send(false)
                }
                self.userFollowers.send(data)
                self.lodingState.send( false)
                
                print(data.count)
            case .failure(let error):
                self.lodingState.send( false)
                self.userFollowers.send(completion: .failure(error))
            }
        }
    }
}

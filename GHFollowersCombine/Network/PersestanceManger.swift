//
//  PersestanceManger.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/19/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

enum persestanceActionType{
    case add,remove
}
enum persestanceManger{
    static private let defults = UserDefaults.standard
    enum Keys {
       static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite:Follower,actionType:persestanceActionType,completed:@escaping(ApiError?)->Void){
        
        retriveFavorites { (result) in
            switch result{
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType{
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {completed(.noData)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll{$0.login == favorite.login}
                }
                completed(save(favorite: retrivedFavorites))
                
            case .failure(let error):
                completed(.AuthError)
            }
        }
        
    }
    
    static func retriveFavorites(completed:@escaping(Result<[Follower],ApiError>)->Void){
        
        guard let favoritesData = defults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let favorites  = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.noData))
        }
    }
    
    
    
    static func save(favorite:[Follower])->ApiError?{
        do{
            let encoder  = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorite)
            defults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return ApiError.noData
        }
}
    
    
    
}




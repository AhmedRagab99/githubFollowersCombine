//
//  FavoriteVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/19/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Combine


class FavoriteVC:UIViewController{
    
    
    let tableView = UITableView()
    var favorites = [Follower]()
    var favoriteViewModel = FavoritesViewModel()
    var subscribers :Set<AnyCancellable> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
         subscribeToFavorites()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToFavorites()
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }

    func subscribeToFavorites(){
          favoriteViewModel.getFavoritesList()
        favoriteViewModel.favorites.sink(receiveCompletion: { _ in
            self.presentGFCAlert(title: "Some thing went wrong", message: "Please try again later😔", buttonTitle: "OK")
        }) { [weak self](favorites) in
            guard let self = self else {return}
            if favorites.count == 0{
                self.showEmptyStateView(message: "No User Found \n Please add user to your Favorites😀", in: self.view)
                self.tableView.isHidden = true
            }
            else {
                self.tableView.isHidden = false
            self.favorites = favorites
            print(self.favorites)
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
            }
        }
    .store(in: &subscribers)
    }

}




extension FavoriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else
        {return UITableViewCell()}
        let favorite = favorites[indexPath.row]
        cell.setFavorite(follower: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let vc = FollowersVC()
        vc.username = favorite.login
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = favorites[indexPath.row]
        favorites.remove(at:indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        persestanceManger.updateWith(favorite: favorite, actionType: .remove) { [weak self](error) in
            guard let self = self else {return}
            guard let error = error else {return}
            self.presentGFCAlert(title: "Unable to remove", message: "Cannot remove this user as \(error.localizedDescription)", buttonTitle: "OK")
            
        }
        
    }
    
    
}

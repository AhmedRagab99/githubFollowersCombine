//
//  FollowersVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Combine

class FollowersVC:UIViewController{
    
    
    enum Section{
        case main
    }
    var followersViewModel = FollowersListViewModel()
    private var subscribers:Set<AnyCancellable> = []
    var userFollowers  = [Follower]()
    var username:String = ""
    var page:Int = 1
    var loadMoreState:Bool = true
    
    var indicator = UIActivityIndicatorView(style: .large)
    var collectionView : UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureIndicator()
        followersViewModel.getFollowers(userName: username,page: page)
        subscribeToUserFollowers()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        isLoadingSubscriber()
        
    }
    
    //MARK:- setup Views
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.setFollower(follower: follower)
            return cell
        })
    }
    
    private func updateData(){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(userFollowers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    private func createThreeColumnFlowLayout()->UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureViewController(){
        self.title = username
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    private func configureIndicator(){
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        print(followersViewModel.lodingState)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK:View Model binding
    
    
    private func isLoadingMoreSubscriber(){
        followersViewModel.loadMore.sink { (val) in
            if val == false{
                self.loadMoreState = val
            }
            print(self.loadMoreState)
            print(self.followersViewModel.loadMore)
        }
        .store(in: &subscribers)
    }
    
    private func isLoadingSubscriber(){
        followersViewModel.lodingState.sink { (val) in
            val == true ? self.indicator.startAnimating():self.indicator.stopAnimating()
            print(val)
            
        }
        .store(in: &subscribers)
    }
    
    private func subscribeToUserFollowers(){
        followersViewModel.userFollowers
            .sink(receiveCompletion: { error in
                self.presentGFCAlert(title: "No username Found!", message: "Please enter another username we need to know who to look for😀", buttonTitle: "OK")
                self.navigationController?.popViewController(animated: true)
            }, receiveValue: { [weak self](users) in
                guard let self = self else{return}
                self.isLoadingSubscriber()
                self.isLoadingMoreSubscriber()
                self.userFollowers.append(contentsOf: users)
                DispatchQueue.main.async {
                    if self.userFollowers.isEmpty{
                        let message = "this user has no followers, Go Follow them"
                        self.showEmptyStateView(message: message, in: self.view)
                    }
                    return
                }
                
                //                    print(self.userFollowers.first?.avatarUrl)
                self.updateData()
                
            })
            .store(in: &subscribers)
    }
    
}
extension FollowersVC:UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > contentHeight-height{
            guard loadMoreState  else {return}
            page+=1
            self.followersViewModel.getFollowers(userName: username, page: page)
            
        }
    }
}

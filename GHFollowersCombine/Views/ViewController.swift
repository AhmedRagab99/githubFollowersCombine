//
//  ViewController.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/6/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Lottie
import Kingfisher
import Alamofire
import Combine


struct post:Codable{
    let userId:Int
    let id:Int
    let title:String
    let body:String
}
func request<T: Codable>(_ url: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parameters: Codable? = nil) -> AnyPublisher<Result<T, AFError>, Never> {
    let publisher = AF.request(url, method: method, headers: headers)
        .validate()
        .publishDecodable(type: T.self)
    return publisher.result()
}
    var cancels : Set<AnyCancellable> = []


class ViewController: UIViewController {

    var indicator = UIActivityIndicatorView(style: .large)
    var tableView = UITableView()
    var tokens :[AnyCancellable] = []

     var cancellable: AnyCancellable?

     var posts: [UserModel] = [] {
        didSet {
            print("posts --> \(self.posts)")
        }
    }
    

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Add it to the view where you want it to appear
       
                
        // Set up its size (the super view bounds usually)
       
       // view.backgroundColor = .systemGray3
        // Do any additional s
      
       activityIndicator()
         tableView.delegate = self
          tableView.dataSource = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     
        view.addSubview(tableView)
       // tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
         //view.addSubview(activityIndicator)
        
        let url = URL(string: "\(BASEURL)users/AhmedRagab99/followers")!
//
//        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: [UserModel].self, decoder: JSONDecoder())
//        .replaceError(with: [])
//        .eraseToAnyPublisher()
//        .assign(to: \.posts, on: self)
        
        fetch(url: url) { (result:Result<[UserModel],Error>) in
            self.indicator.startAnimating()

            switch result{
               
            case .success(let users):
                self.indicator.stopAnimating()
                self.posts = users
                self.tableView.reloadData()
            case.failure(let error ):
        self.indicator.stopAnimating()
                print(error.localizedDescription)
            }
        }
    
//        AF.request("\(BASEURL)users/AhmedRagab99/following")
//            .publishDecodable(type:[UserModel].self,decoder: JSONDecoder())
//            .sink{
//                responce in
//                switch responce.result{
//
//                case .success(let r):
//                    self.posts = r
//                    self.tableView.reloadData()
//
//                case .failure(let err):
//                    print(err.localizedDescription)
//                }
//        }
//
//      .store(in: &tokens)
        

          

                  
        

}
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.posts[indexPath.row].avatar_url
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.posts.count
       }
}


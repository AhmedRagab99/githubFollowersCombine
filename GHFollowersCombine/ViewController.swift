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


class ViewController: UIViewController {

    var tableView = UITableView()
    var tokens :[AnyCancellable] = []

     var cancellable: AnyCancellable?

     var posts: [UserModel] = [] {
        didSet {
            print("posts --> \(self.posts)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .systemGray3
        // Do any additional s
      
        tableView.frame = view.bounds
         tableView.delegate = self
          tableView.dataSource = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     
        view.addSubview(tableView)
        
        let url = URL(string: "\(BASEURL)users/AhmedRagab99/followers")!
//
//        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: [UserModel].self, decoder: JSONDecoder())
//        .replaceError(with: [])
//        .eraseToAnyPublisher()
//        .assign(to: \.posts, on: self)
        
        
        AF.request("\(BASEURL)users/AhmedRagab99/following")
            .publishDecodable(type:[UserModel].self,decoder: JSONDecoder())
            .sink{
                responce in
                switch responce.result{

                case .success(let r):
                    self.posts = r
                    self.tableView.reloadData()

                case .failure(let err):
                    print(err.localizedDescription)
                }
        }

      .store(in: &tokens)
        

          

                  
        

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


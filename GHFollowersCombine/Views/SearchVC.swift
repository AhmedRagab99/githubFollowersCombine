//
//  SearchVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/11/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Combine

class SearchVC:UIViewController{
    
    //MARK:- variabels
    
    let logoImageView = UIImageView()
    let userNametextField = GHCTextField()
    let passwordTextField = GHCTextField()
    let confirmPasswordTextField = GHCTextField()
    let callToActionButton = GFCButton(backgroundColor: .label, title: "Get Followers")
    var stackView :UIStackView!
    var indicator = UIActivityIndicatorView(style: .large)
    var loginViewModel = LoginFormViewModel()
    var FollowersUsers = [UserModel]()
    var toFollowersList = false
    
    private var validationSubscriber :Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextFields()
        configureStackView()
        configurecallToActionButton()
        dismissTheKeyboared()
        bindTextFieldsToViewModel()
        bindButtonValidationToViewModel()
        configureIndicator()
        NavigateToUserFollowersList()
        isLoadingSubscriber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    
    //MARK:View Model binding
    private func getUserFollowersObservers(){
        loginViewModel.fetchUser(userName: userNametextField.text ?? "")
    }
    
    
    private func isLoadingSubscriber(){
        loginViewModel.$lodingState.sink { (val) in
                   val == true ? self.indicator.startAnimating():self.indicator.stopAnimating()
               }
           .store(in: &validationSubscriber)
    }
    
    private func NavigateToUserFollowersList(){
        loginViewModel.userFollowers
            .sink(receiveCompletion: { error in
                self.presentGFCAlert(title: "No username found", message: "please try again with a valid username we need to know who to look for😀", buttonTitle: "OK")
                self.indicator.stopAnimating()
            }, receiveValue: { [weak self](users) in
                guard let self = self else{return}
                self.FollowersUsers = users
                if self.FollowersUsers.count != 0{
                    let vc = FollowersVC()
                    vc.userFollowers = self.FollowersUsers
                    self.navigationController?.pushViewController(vc, animated: true)
                }else {
                    self.presentGFCAlert(title: "No username found", message: "please try again with a valid username we need to know who to look for😀", buttonTitle: "OK")
                    self.navigationController?.popViewController(animated: true)
                }
                
            })
            .store(in: &validationSubscriber)
    }
    
    
    private func bindButtonValidationToViewModel(){
        
        // for the viewModelValidation
        
        loginViewModel
            .validateCredintials
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: callToActionButton)
            .store(in: &validationSubscriber)
        
        // for the ui update
        
        loginViewModel.validateCredintials
            .assignValidationColors(to:callToActionButton)
            .store(in:&validationSubscriber)
    }
    private func bindTextFieldsToViewModel(){
        // for the viewModelValidation
        userNametextField.textPublisher
            .assign(to: \.userName, on: loginViewModel)
            .store(in: &validationSubscriber)
        
        
        passwordTextField.textPublisher
            .assign(to: \.password, on: loginViewModel)
            .store(in: &validationSubscriber)
        confirmPasswordTextField.textPublisher
            .assign(to: \.confirmPassword, on: loginViewModel)
            .store(in: &validationSubscriber)
       
        
        // for the ui update
        
        loginViewModel.validatePassword
            .assignValidationColor(to:userNametextField)
            .store(in:&validationSubscriber)
        
        loginViewModel.validatePassword
            .assignValidationColor(to:passwordTextField)
            .store(in:&validationSubscriber)
        
        loginViewModel.validatePassword
            .assignValidationColor(to:confirmPasswordTextField)
            .store(in:&validationSubscriber)
        
    }
    
    
    
    
    //MARK:- setup Views

    private func dismissTheKeyboared(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func configureIndicator(){
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        loginViewModel.lodingState ? indicator.startAnimating() : indicator.stopAnimating()
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 50),
            indicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTextFields(){
        passwordTextField.placeholder = "Enter your password"
        confirmPasswordTextField.placeholder = "Enter password agian"
        userNametextField.placeholder = " Enter your username"
        userNametextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func configureLogoImageView(){
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureStackView(){
        self.stackView = UIStackView(arrangedSubviews:[userNametextField,passwordTextField,confirmPasswordTextField])
        view.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 10
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            self.stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            self.stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    
    @objc private func btnTapped(){
        print("tapped")
        getUserFollowersObservers()
    }
    
    private func configurecallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

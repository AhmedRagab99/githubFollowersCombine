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
    var loginViewModel = LoginFormViewModel()
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
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
               navigationController?.setNavigationBarHidden(true, animated: true)

        
    }
    
    
    //MARK:View Model binding
  
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

    
    private func toFollowersVC(){
        let vc = FollowersVC()
        vc.username = self.userNametextField.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func dismissTheKeyboared(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
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
       toFollowersVC()
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

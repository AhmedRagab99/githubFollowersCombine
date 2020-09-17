//
//  PublisherExtenstions.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Combine
import UIKit

extension AnyPublisher where Output == Bool, Failure == Never {
    func assignValidationColor(to textField: UITextField) -> AnyCancellable {
        return map({ (value) -> UIColor in
            return value ? UIColor.systemBackground : UIColor.systemPink.withAlphaComponent(0.4)
            })
            
            .assign(to: \.backgroundColor, on: textField)
    }
    
    func assignValidationColors(to View: UIView) -> AnyCancellable {
           return
            map({ (value) -> UIColor in
                return value ? .systemGreen : UIColor.systemGreen.withAlphaComponent(0.2)
               })
               .assign(to: \.backgroundColor, on: View)
       }
}


extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .map { $0.text ?? "" } // mapping UITextField to extract text
            .eraseToAnyPublisher()
    }
}

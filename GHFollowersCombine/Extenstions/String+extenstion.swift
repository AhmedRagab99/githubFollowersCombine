//
//  String+extenstion.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

extension String {
    
    
    func convertToDate()->Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    
    func displayDateInString()->String{
        guard let date = convertToDate() else {return "N/A"}
        return date.formatDateToMonthAndDay()
    }
}
extension Date{
    func formatDateToMonthAndDay()->String{
        let dateFormmater  = DateFormatter()
        dateFormmater.dateFormat = "MMM d, yyyy"
        return dateFormmater.string(from: self)
    }
    
}


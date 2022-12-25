//
//  Date + Extension.swift
//  Notes
//
//  Created by Dyadichev on 24.12.2022.
//

import Foundation

extension Date {
    
    func format() -> String {
        
        let formatter = DateFormatter()
        
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mm a"
            
        } else {
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: self)
    }
}

//
//  Date+Configuration.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import Foundation

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

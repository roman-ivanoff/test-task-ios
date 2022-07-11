//
//  PostItem.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import Foundation

struct PostItem: Codable {
    let id: Int
    let timeshamp: UInt64
    let title: String
    let previewText: String
    let likesCount: Int


    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }

    func getDateByTimestamp(timestamp: UInt64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }

    func getPastDays(pastDate: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: pastDate, to: Date()).day ?? 0
    }
}

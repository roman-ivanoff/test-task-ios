//
//  Post.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import Foundation

struct Post: Codable {
    let id: Int
    let timeshamp: UInt64
    let title: String
    let text: String
    let postImage: String
    let likesCount: Int

        enum CodingKeys: String, CodingKey {
            case id = "postId"
            case timeshamp
            case title
            case text
            case postImage
            case likesCount = "likes_count"
        }

    func getDateByTimestamp(timestamp: UInt64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
}

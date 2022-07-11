//
//  PostsService.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import Foundation

enum PostError: Error {
    case noDataAvailable
    case cannotProcessData
}

class PostsService {
    let session = URLSession(configuration: .default)
    let link = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    var dataTask: URLSessionDataTask?

    func getPostData(completion: @escaping(Result<PostListResponse, PostError>) -> Void) {
        guard let url = URL(string: link) else { return }
        dataTask = session.dataTask(with: url) { data, _, _ in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let postResponse = try decoder.decode(PostListResponse.self, from: jsonData)

                completion(.success(postResponse))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }

        dataTask?.resume()
    }
}

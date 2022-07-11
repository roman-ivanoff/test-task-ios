//
//  PostService.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import UIKit

class PostService {
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func getPost(id: Int, completion: @escaping(Result<PostResponse, PostError>) -> Void) {
        let link =
        "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json"
        guard let url = URL(string: link) else { return }

        dataTask = session.dataTask(with: url) { data, _, _ in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let postResponse = try decoder.decode(PostResponse.self, from: jsonData)

                completion(.success(postResponse))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }

        dataTask?.resume()
    }
}


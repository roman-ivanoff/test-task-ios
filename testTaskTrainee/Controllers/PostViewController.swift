//
//  PostViewController.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!

    let postService = PostService()
    var post: Post?
    var image: UIImage?
    var postId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        postService.getPost(id: postId) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(let error):
                print(error)
            case .success(let post):
                self.post = post.post
                self.configureUI()
            }
        }
    }

    private func configureUI() {
        guard let post = post else {
            return
        }

        DispatchQueue.main.async {
            self.titleLabel.text = post.title
            self.postTextLabel.text = post.text
            self.postImage.load(url: URL(string: self.post!.postImage)!)

            let date = post.getDateByTimestamp(timestamp: post.timeshamp)
            let calendarDate = Calendar.current
            self.daysLabel.text = "\(calendarDate.component(.day, from: date)) \(date.month) \(calendarDate.component(.year, from: date))"

            self.likesLabel.text = String(post.likesCount)
            self.heartImage.isHidden = false
        }

    }
}

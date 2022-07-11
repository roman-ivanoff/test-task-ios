//
//  ViewController.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 10.07.2022.
//

import UIKit

class ViewController: UIViewController {
    var cellsState = [Bool]()
    let expandButtonWithd = 42
    let maxNumberOfLines =  2
    @IBOutlet weak var tableView: UITableView!
    let queryService = PostsService()
    var postId: Int?

    var postList = [PostItem]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.cellsState = [Bool](repeating: false, count: self.postList.count)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        tableView.delegate = self
        tableView.dataSource = self

        queryService.getPostData { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self.postList = posts.posts
            }
        }
    }
    
    @IBAction func sortByRating(_ sender: UIBarButtonItem) {
        postList.sort(by: { $0.likesCount > $1.likesCount })
        tableView.reloadData()
    }
    
    @IBAction func sortByDate(_ sender: UIBarButtonItem) {
        postList.sort(by: { $0.timeshamp > $1.timeshamp })
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
    IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

        if let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell {
            let post = postList[indexPath.row]
            postCell.expandButtonState = .hide
            postCell.isExpanded = cellsState[indexPath.row]

            postCell.daysLabel?.text = "\(post.getPastDays(pastDate: post.getDateByTimestamp(timestamp: post.timeshamp))) days ago"
            postCell.likesLabel?.text = String(post.likesCount)
            postCell.postTextLabel?.text = post.previewText
            postCell.titleLabel?.text = post.title

            if postCell.postTextLabel.maxNumberOfLines != maxNumberOfLines {
                postCell.expandButtonState = .show
            }

            postCell.expandActionCallback = {
                postCell.isExpanded = self.cellsState[indexPath.row]
                self.cellsState[indexPath.row] = !self.cellsState[indexPath.row]
                tableView.reloadRows(at: [indexPath], with: .right)
            }

            cell = postCell
        }


            return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        postId = postList[indexPath.row].id
        performSegue(withIdentifier: "postId", sender: postId)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! PostViewController
        destController.postId = postId
    }
}

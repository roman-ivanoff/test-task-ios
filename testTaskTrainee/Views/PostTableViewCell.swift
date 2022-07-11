//
//  PostTableViewCell.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import UIKit

enum ExpandButtonState  {
    case show
    case hide
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!

    private let btnHeight = 42.0
    var expandActionCallback: (() -> ())?

    var expandButtonState: ExpandButtonState = .hide {
        didSet {
            if expandButtonState == .hide {
                expandButton.isHidden = true
                buttonHeight.constant = 0
            } else {
                expandButton.isHidden = false
                buttonHeight.constant = btnHeight
            }
        }
    }

    var isExpanded = false {
        didSet {
            if isExpanded == false {
                postTextLabel.numberOfLines = 2
                expandButton.setTitle("Expand", for: .normal)
            } else {
                postTextLabel.numberOfLines = 0
                expandButton.setTitle("Collapse", for: .normal)
            }
        }
    }

    
    @IBAction func expandAction(_ sender: UIButton) {
        expandActionCallback?()
    }
}

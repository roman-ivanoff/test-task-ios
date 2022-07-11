//
//  UILabel+Configuration.swift
//  testTaskTrainee
//
//  Created by Roman Ivanov on 11.07.2022.
//

import UIKit

extension UILabel {

    var maxNumberOfLines: Int {
            let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
            let text = (self.text ?? "") as NSString
            let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
            let lineHeight = font.lineHeight
            return Int(ceil(textHeight / lineHeight))
        }
}

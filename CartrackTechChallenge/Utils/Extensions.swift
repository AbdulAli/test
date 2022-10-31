//
//  Extensions.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 13/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UILabel {
    func set(image: UIImage, with text: String, width: Int, height: Int) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -1, width: width, height: height)
        let attachmentStr = NSAttributedString(attachment: attachment)

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)

        let textString = NSAttributedString(string: " \(text)", attributes: [.font: self.font ?? UIFont()])
        mutableAttributedString.append(textString)

        self.attributedText = mutableAttributedString
    }
}

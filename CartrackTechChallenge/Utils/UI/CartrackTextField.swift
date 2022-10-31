//
//  CartrackTextField.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import UIKit

@IBDesignable
final class CartrackTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let placeholder = placeholder {
            let placeholderString = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: UIColor(named: "cartrackTextFieldPlaceholderText") ?? .black])
            attributedPlaceholder = placeholderString
        }
        setup()
    }

    func setup() {
        textColor = UIColor(named: "text")
        tintColor = UIColor(named: "cartrackTextFieldBorder") ?? .black

        clipsToBounds = true
        layer.backgroundColor = UIColor(named: "cartrackTextFieldBackground")?.cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "cartrackTextFieldBorder")?.cgColor
    }
}

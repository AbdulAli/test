//
//  CartrackButton.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 10/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import UIKit

@IBDesignable
final class CartrackButton: UIButton {

    // This flag will define the button aspect between filled and bordered
    @IBInspectable var buttonFilled: Bool = true {
        didSet {
            // Setting the flag will trigger setup to redesign the view
            setup()
        }
    }

    @IBInspectable var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
            setTitleColor(buttonFilled ?
                UIColor(named: "cartrackFilledbuttonTitleText") :
                UIColor(named: "cartrackBorderedButtonTitleText"), for: .normal)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    // Button layout setup according to the buttonFilled flag
    func setup() {
        titleLabel?.textColor = buttonFilled ?
            UIColor(named: "cartrackFilledbuttonTitleText") :
            UIColor(named: "cartrackBorderedButtonTitleText")

        clipsToBounds = false
        layer.cornerRadius = 4

        // If the button type is bordered
        // A border will additionaly be added to the button
        if !buttonFilled {
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: "cartrackBorderedButtonBorder")?.cgColor
        }

        layer.backgroundColor = buttonFilled ?
            UIColor(named: "cartrackFilledButtonFill")?.cgColor :
            UIColor(named: "cartrackBorderedButtonFill")?.cgColor

        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowColor = UIColor(named: "cartrackButtonShadow")?.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 22
    }
}

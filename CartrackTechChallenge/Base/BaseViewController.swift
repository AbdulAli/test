//
//  BaseViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 11/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import UIKit

internal class BaseViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        /// Creates observers for when the keyboard is opened or closed
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        /// Remove observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    /// Moves the view upwards when the keyboard is opened
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let buttonFrame = view.convert(registerButton.frame, from: frameView)
            let buttonHeight = view.frame.size.height - (buttonFrame.size.height + buttonFrame.origin.y)
            let bottomConstraint: CGFloat = 32

            // Only moves the view if it is in its original position
            // Only moves the view if the keyboard covers the login button
            if view.frame.origin.y == 0, keyboardHeight + bottomConstraint > buttonHeight {
                // Adds some padding to simulate a bottom constraint
                view.frame.origin.y -= (keyboardHeight - buttonHeight) + bottomConstraint
            }
        }
    }

    /// Moves the view to its original position when the keyboard is closed
    @objc private func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

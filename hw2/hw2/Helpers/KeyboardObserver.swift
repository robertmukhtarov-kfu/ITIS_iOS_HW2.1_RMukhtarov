//
//  KeyboardObserver.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import UIKit

protocol KeyboardObserverDelegate: AnyObject {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double)
    func keyboardWillHide(animationDuration: Double)
}

final class KeyboardObserver {

    // MARK: - Internal Properties

    weak var delegate: KeyboardObserverDelegate?

    // MARK: - Initializers

    init(delegate: KeyboardObserverDelegate) {
        self.delegate = delegate
    }

    // MARK: - Internal Methods

    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Private Methods

    @objc private func onKeyboardWillShow(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else {
            return
        }
        delegate?.keyboardWillShow(keyboardFrame: keyboardFrame, animationDuration: animationDuration)
    }

    @objc private func onKeyboardWillHide(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else {
            return
        }
        delegate?.keyboardWillHide(animationDuration: animationDuration)
    }
}

//
//  MessageTextField.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import UIKit

final class MessageTextField: UITextField {

    // MARK: - Constants

    private enum LayoutConstants {
        static let sendButtonImageInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        static let boundsInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 48.0)
        static let height = 40.0
        static let borderWidth = 1.0
    }

    // MARK: - Private Properties

    private let onSendButtonPressed: (String) -> Void

    // MARK: - Views

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.sendButton.image, for: .normal)
        button.imageEdgeInsets = LayoutConstants.sendButtonImageInsets
        button.addTarget(self, action: #selector(didPressSendButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Overridden Internal Properties and Methods

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = Asset.Colors.Chat.TextField.stroke.color.cgColor
        }
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: LayoutConstants.height)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: LayoutConstants.boundsInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: LayoutConstants.boundsInsets)
    }

    // MARK: - Initializers

    init(onSendButtonPressed: @escaping (String) -> Void) {
        self.onSendButtonPressed = onSendButtonPressed
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        rightView = sendButton
        rightViewMode = .always
        backgroundColor = Asset.Colors.Chat.TextField.background.color
        font = .habibi(size: 14, textStyle: .body)
        adjustsFontForContentSizeCategory = true
        textColor = Asset.Colors.Chat.TextField.text.color
        layer.borderWidth = LayoutConstants.borderWidth
        layer.borderColor = Asset.Colors.Chat.TextField.stroke.color.cgColor
        layer.cornerRadius = LayoutConstants.height / 2
        layer.masksToBounds = true
        attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes: [.foregroundColor: Asset.Colors.Chat.TextField.text.color])
    }

    @objc private func didPressSendButton() {
        guard let messageText = text, !messageText.isEmpty else { return }
        onSendButtonPressed(messageText)
        text = ""
    }
}

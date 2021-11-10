//
//  MessageView.swift
//  hw2
//
//  Created by RRMukhtarov on 02.11.2021.
//

import UIKit
import SnapKit

final class MessageView: UIView {

    // MARK: - Constants

    private enum LayoutConstants {
        static let cornerRadiusSmall = 4.0
        static let cornerRadiusBig = 12.0
        static let insets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    }

    // MARK: - Private Properties

    private let sender: MessageGroup.Sender
    private let text: String

    // MARK: - Views

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: 14, textStyle: .body)
        label.text = text
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    // MARK: - Overridden Internal Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }

    // MARK: - Initializers

    init(text: String, sender: MessageGroup.Sender) {
        self.sender = sender
        self.text = text
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        layer.cornerRadius = LayoutConstants.cornerRadiusSmall
        layer.masksToBounds = true

        switch sender {
        case .user:
            backgroundColor = Asset.Colors.Chat.blueMessage.color
            label.textColor = Asset.Colors.Chat.userText.color
        case .interlocutor:
            backgroundColor = Asset.Colors.Chat.grayMessage.color
            label.textColor = Asset.Colors.Chat.interlocutorText.color
        }

        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(LayoutConstants.insets)
        }
    }

    private func roundCorners() {
        let corners: UIRectCorner
        switch sender {
        case .user:
            corners = [.bottomLeft, .topLeft, .topRight]
        case .interlocutor:
            corners = [.bottomLeft, .bottomRight, .topRight]
        }

        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: LayoutConstants.cornerRadiusBig, height: 0.0)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

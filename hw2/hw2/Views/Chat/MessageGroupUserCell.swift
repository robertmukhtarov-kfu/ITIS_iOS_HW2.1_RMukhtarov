//
//  MessageGroupUserCell.swift
//  hw2
//
//  Created by RRMukhtarov on 02.11.2021.
//

import UIKit
import SnapKit

final class MessageGroupUserCell: UITableViewCell {

    // MARK: - Constants

    private enum LayoutConstants {
        enum AvatarView {
            static let width = 24.0
            static let height = 24.0
        }

        enum MessagesStackView {
            static let topOffset = 12.0
            static let bottomInset = 12.0
            static let trailingInset = 16.0
            static let leadingInset = 59.0
            static let spacing = 4.0
        }
    }

    // MARK: - Views

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: 12, textStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var messagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.spacing = LayoutConstants.MessagesStackView.spacing
        return stackView
    }()
    
    // MARK: - Internal Methods
    
    func configure(with messageGroup: MessageGroup) {
        messagesStackView.subviews.forEach { $0.removeFromSuperview() }
        messageGroup.messages.forEach { message in
            let messageView = MessageView(text: message, sender: messageGroup.sender)
            messagesStackView.addArrangedSubview(messageView)
        }
        timeLabel.text = DateFormatter.time.string(from: messageGroup.date)
        messagesStackView.addArrangedSubview(timeLabel)
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods: Setup

    private func setup() {
        contentView.backgroundColor = Asset.Colors.background.color
        contentView.addSubview(messagesStackView)
        messagesStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutConstants.MessagesStackView.topOffset)
            make.bottom.equalToSuperview().inset(LayoutConstants.MessagesStackView.bottomInset).priority(.high)
            make.trailing.equalToSuperview().inset(LayoutConstants.MessagesStackView.trailingInset)
            make.leading.equalToSuperview().inset(LayoutConstants.MessagesStackView.leadingInset)
        }
        timeLabel.textColor = Asset.Colors.Chat.userTime.color
    }
}

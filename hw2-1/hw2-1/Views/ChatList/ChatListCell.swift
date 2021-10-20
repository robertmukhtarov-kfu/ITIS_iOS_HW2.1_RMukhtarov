//
//  ChatListCell.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

final class ChatListCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        enum ContainerStackView {
            static let spacing: CGFloat = 8.0
            static let inset: CGFloat = 24.0
        }
        
        enum NameDateStackView {
            static let spacing: CGFloat = 8.0
        }
        
        enum TextStackView {
            static let spacing: CGFloat = 4.0
        }
        
        enum AvatarView {
            static let height: CGFloat = 40.0
            static let width: CGFloat = 40.0
        }
        
        enum Spacer {
            static let width: CGFloat = 19.0
        }
        
        enum Divider {
            static let height: CGFloat = 1.0
        }
    }
    
    private enum FontSize {
        static let nameLabel: CGFloat = 14
        static let dateLabel: CGFloat = 12
        static let messagePreviewLabel: CGFloat = 14
    }
    
    // MARK: - Views
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.chatListGray.color
        return view
    }()
    
    private lazy var avatarView = AvatarView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: FontSize.nameLabel, textStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: FontSize.dateLabel, textStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var nameDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stackView.spacing = LayoutConstants.NameDateStackView.spacing
        return stackView
    }()
    
    private lazy var messagePreviewLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: FontSize.messagePreviewLabel, textStyle: .body)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var messagePreviewStackView: UIStackView = {
        let spacer = Spacer(size: CGSize(width: LayoutConstants.Spacer.width, height: -1))
        spacer.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        let stackView = UIStackView(arrangedSubviews: [messagePreviewLabel, spacer])
        return stackView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameDateStackView, messagePreviewStackView])
        stackView.axis = .vertical
        stackView.spacing = LayoutConstants.TextStackView.spacing
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarView, textStackView])
        stackView.spacing = LayoutConstants.ContainerStackView.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Internal Methods
    
    func configure(with chatListItem: ChatListItem) {
        avatarView.configure(
            withImage: chatListItem.image,
            withName: chatListItem.name
        )
        nameLabel.text = chatListItem.name
        messagePreviewLabel.text = chatListItem.messagePreview
        dateLabel.text = chatListItem.date
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private Methods: Setup
    
    private func setup() {
        contentView.addSubview(containerStackView)
        contentView.addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        let dividerHeight = LayoutConstants.Divider.height
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: dividerHeight),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -dividerHeight)
        ])
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: LayoutConstants.AvatarView.width),
            avatarView.heightAnchor.constraint(equalToConstant: LayoutConstants.AvatarView.height)
        ])
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        let inset = LayoutConstants.ContainerStackView.inset
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}

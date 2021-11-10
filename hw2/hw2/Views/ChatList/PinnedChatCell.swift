//
//  PinnedChatCell.swift
//  hw2
//
//  Created by RRMukhtarov on 13.10.2021.
//

import UIKit
import SnapKit

final class PinnedChatCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        enum StackView {
            static let spacing: CGFloat = 8.0
        }
        
        enum AvatarView {
            static let height: CGFloat = 48.0
            static let width: CGFloat = 48.0
        }
    }
    
    private enum FontSize {
        static let nameLabel: CGFloat = 13
    }
    
    // MARK: - Views
    
    private lazy var avatarView = AvatarView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: FontSize.nameLabel, textStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarView, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = LayoutConstants.StackView.spacing
        return stackView
    }()
    
    // MARK: - Internal Methods
    
    func configure(with pinnedChat: PinnedChat) {
        avatarView.configure(
            withImage: pinnedChat.image,
            withName: pinnedChat.name
        )
        nameLabel.text = pinnedChat.name
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
        contentView.addSubview(stackView)

        avatarView.snp.makeConstraints { make in
            make.width.equalTo(LayoutConstants.AvatarView.width)
            make.height.equalTo(LayoutConstants.AvatarView.height)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

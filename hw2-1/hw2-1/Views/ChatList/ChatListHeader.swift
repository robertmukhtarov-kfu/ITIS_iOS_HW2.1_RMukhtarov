//
//  PinnedChatsHeader.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

final class ChatListHeader: UICollectionReusableView {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        static let dividerHeight: CGFloat = 1.0
    }
    
    // MARK: - Views
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.chatListGray.color
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private Methods: Setup
    
    private func setupView() {
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: LayoutConstants.dividerHeight),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -LayoutConstants.dividerHeight)
        ])
    }
}

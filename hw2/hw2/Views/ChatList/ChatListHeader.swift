//
//  PinnedChatsHeader.swift
//  hw2
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit
import SnapKit

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
        divider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(LayoutConstants.dividerHeight)
            make.bottom.equalToSuperview().offset(-LayoutConstants.dividerHeight)
        }
    }
}

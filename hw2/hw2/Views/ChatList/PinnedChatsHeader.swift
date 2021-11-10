//
//  PinnedChatsHeader.swift
//  hw2
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit
import SnapKit

final class PinnedChatsHeader: UICollectionReusableView {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        enum TitleLabel {
            static let topOffset: CGFloat = 8.0
            static let bottomOffset: CGFloat = -16.0
        }
    }
    
    private enum FontSize {
        static let titleLabel: CGFloat = 12
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PINNED"
        label.font = .habibi(size: FontSize.titleLabel, textStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(LayoutConstants.TitleLabel.topOffset)
            make.bottom.equalToSuperview().offset(LayoutConstants.TitleLabel.bottomOffset).priority(.high)
        }
    }
}

//
//  PinnedChatsHeader.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.TitleLabel.topOffset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: LayoutConstants.TitleLabel.bottomOffset)
        ])
    }
}

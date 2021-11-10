//
//  PrimaryButton.swift
//  hw2
//
//  Created by RRMukhtarov on 10.10.2021.
//

import UIKit

final class PrimaryButton: UIButton {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        static let verticalPadding: CGFloat = 9.0
        static let horizontalPadding: CGFloat = 32.0
        static let spacing: CGFloat = 17.0
        static let borderWidth: CGFloat = 1.0
    }
    
    private enum FontSize {
        static let titleLabel: CGFloat = 14
    }
    
    // MARK: - Overridden Internal Methods
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = Asset.Colors.buttonBorder.color.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
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
    
    convenience init(title: String, image: UIImage) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
    }
    
    // MARK: - Private Methods: Setup
    
    private func setup() {
        tintColor = .label
        setTitleColor(.label, for: .normal)
        adjustsImageSizeForAccessibilityContentSizeCategory = true
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.font = .habibi(size: FontSize.titleLabel, textStyle: .body)
        layer.borderWidth = LayoutConstants.borderWidth
        layer.borderColor = Asset.Colors.buttonBorder.color.cgColor
        setInsets(
            contentPadding: UIEdgeInsets(
                top: LayoutConstants.verticalPadding,
                left: LayoutConstants.horizontalPadding,
                bottom: LayoutConstants.verticalPadding,
                right: LayoutConstants.horizontalPadding
            ),
            imageTitleSpacing: LayoutConstants.spacing
        )
    }
}

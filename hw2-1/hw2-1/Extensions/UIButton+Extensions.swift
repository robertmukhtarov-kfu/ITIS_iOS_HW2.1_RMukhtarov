//
//  UIButton+Extensions.swift
//  hw2-1
//
//  Created by RRMukhtarov on 10.10.2021.
//

import UIKit

extension UIButton {
    func setInsets(contentPadding: UIEdgeInsets, imageTitleSpacing: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitleSpacing
        )
        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: imageTitleSpacing,
            bottom: 0.0,
            right: -imageTitleSpacing
        )
    }
}

//
//  UIFont+Extensions.swift
//  hw2
//
//  Created by RRMukhtarov on 10.10.2021.
//

import UIKit

extension UIFont {
    static func habibi(size: CGFloat, textStyle: UIFont.TextStyle) -> UIFont {
        guard let habibiFont = UIFont(font: FontFamily.Habibi.regular, size: size) else {
            fatalError("Failed to initialize font")
        }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: habibiFont)
    }
}

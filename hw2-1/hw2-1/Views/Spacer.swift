//
//  Spacer.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

final class Spacer: UIView {
    
    // MARK: - Private Properties
    
    private let spacerSize: CGSize
    
    // MARK: - Overridden Internal Properties and Methods
    
    override var intrinsicContentSize: CGSize {
        spacerSize
    }
    
    override func contentHuggingPriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        .required
    }
    
    // MARK: - Initializers
    
    init(size: CGSize) {
        spacerSize = size
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MessageGroupHeader.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import UIKit
import SnapKit

final class MessageGroupHeader: UITableViewHeaderFooterView {

    // MARK: - Constants

    private enum LayoutConstants {
        static let topOffset = 6.0
        static let bottomInset = 12.0
    }

    // MARK: - Views

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: 12, textStyle: .headline)
        label.textColor = Asset.Colors.Chat.date.color
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    // MARK: - Internal Methods

    func configure(with text: String) {
        label.text = text
    }

    // MARK: - Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods: View Setup

    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutConstants.topOffset)
            make.bottom.equalToSuperview().inset(LayoutConstants.bottomInset).priority(.high)
            make.centerX.equalToSuperview()
        }
    }
}

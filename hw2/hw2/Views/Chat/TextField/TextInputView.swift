//
//  TextInputView.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import UIKit
import SnapKit

final class TextInputView: UIView {

    // MARK: - Constants

    private enum LayoutConstants {
        enum Divider {
            static let height = 1.0
        }

        enum TextField {
            static let topOffset = 12.0
            static let bottomInset = 12.0
            static let horizontalInsets = 16.0
        }
    }

    // MARK: - Private Properties

    private let onSendButtonPressed: (String) -> Void

    // MARK: - Views

    private lazy var textField = MessageTextField(onSendButtonPressed: onSendButtonPressed)

    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.chatListGray.color
        return view
    }()

    // MARK: - Initializers

    init(onSendButtonPressed: @escaping (String) -> Void) {
        self.onSendButtonPressed = onSendButtonPressed
        super.init(frame: .zero)
        setupView()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods: View Setup

    private func setupView() {
        backgroundColor = Asset.Colors.Chat.TextField.inputAreaBackground.color
    }

    private func addSubviews() {
        addSubview(divider)
        addSubview(textField)
    }

    private func makeConstraints() {
        divider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(LayoutConstants.Divider.height)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(LayoutConstants.TextField.topOffset)
            make.bottom.equalToSuperview().inset(LayoutConstants.TextField.bottomInset)
            make.leading.trailing.equalToSuperview().inset(LayoutConstants.TextField.horizontalInsets)
        }
    }
}

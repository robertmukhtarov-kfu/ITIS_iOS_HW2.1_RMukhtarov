//
//  ViewController.swift
//  hw2
//
//  Created by RRMukhtarov on 10.10.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        enum AddressLabel {
            static let topOffset: CGFloat = 19.0
            static let leadingOffset: CGFloat = 25.0
        }
    }
    
    private enum FontSize {
        static let addressLabel: CGFloat = 14
        static let messagesBarButtonItem: CGFloat = 17
    }
    
    // MARK: - Views
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Brooklyn, NY"
        label.font = .habibi(size: FontSize.addressLabel, textStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var logoutButton = PrimaryButton(
        title: "Logout",
        image: Asset.Images.buttonArrowLeft.image
    )
    
    private lazy var messagesBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "Messages",
            style: .plain,
            target: self,
            action: #selector(didPressMessagesBarButtonItem)
        )
        barButtonItem.setTitleTextAttributes(
            [.font : UIFont.habibi(size: FontSize.messagesBarButtonItem, textStyle: .body)],
            for: .normal
        )
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Private Methods: Setup
    
    private func setupView() {
        view.backgroundColor = Asset.Colors.background.color
        title = "Alex Tsimikas"
        navigationItem.rightBarButtonItem = messagesBarButtonItem
        navigationItem.backButtonTitle = ""
    }
    
    private func addSubviews() {
        view.addSubview(addressLabel)
        view.addSubview(logoutButton)
    }
    
    private func makeConstraints() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: LayoutConstants.AddressLabel.topOffset
            ),
            addressLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: LayoutConstants.AddressLabel.leadingOffset
            )
        ])
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Private Methods: Actions
    
    @objc private func didPressMessagesBarButtonItem() {
        let chatListVC = ChatListViewController()
        navigationController?.pushViewController(chatListVC, animated: true)
    }
}


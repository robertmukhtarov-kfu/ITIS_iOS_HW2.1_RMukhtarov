//
//  ChatViewController.swift
//  hw2
//
//  Created by RRMukhtarov on 02.11.2021.
//

import UIKit
import SnapKit

final class ChatViewController: UIViewController {

    // MARK: - Reuse Identifiers

    private let messageGroupUserCellReuseIdentifier = "messageGroupUserCellReuseIdentifier"
    private let messageGroupInterlocutorCellReuseIdentifier = "messageGroupInterlocutorCellReuseIdentifier"
    private let messageGroupHeaderReuseIdentifier = "messageGroupHeaderReuseIdentifier"

   // MARK: - Private Properties

    private let interlocutorName: String
    private let interlocutorImage: UIImage?
    private let chatService = ChatService()
    private var messages: [MessageSection] = []
    private lazy var keyboardObserver = KeyboardObserver(delegate: self)

    private lazy var sendMessage: (String) -> Void = { [weak self] text in
        guard let self = self else { return }
        self.chatService.sendMessage(text: text)
        self.messages = self.chatService.loadMessages()
        self.tableView.reloadData()
        let lastSection = self.tableView.numberOfSections - 1
        let indexPath = IndexPath(
            row: self.tableView.numberOfRows(inSection: lastSection) - 1,
            section: lastSection
        )
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = Asset.Colors.background.color
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            MessageGroupUserCell.self,
            forCellReuseIdentifier: messageGroupUserCellReuseIdentifier
        )
        tableView.register(
            MessageGroupInterlocutorCell.self,
            forCellReuseIdentifier: messageGroupInterlocutorCellReuseIdentifier
        )
        tableView.register(
            MessageGroupHeader.self,
            forHeaderFooterViewReuseIdentifier: messageGroupHeaderReuseIdentifier
        )
        return tableView
    }()

    private lazy var textInputView = TextInputView(onSendButtonPressed: sendMessage)

    // MARK: - Overridden Internal Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstraints()
        keyboardObserver.subscribeToNotifications()
        messages = chatService.loadMessages()
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardObserver.unsubscribeFromNotifications()
    }

    // MARK: - Initializers

    init(interlocutorName: String, interlocutorImage: UIImage?) {
        self.interlocutorName = interlocutorName
        self.interlocutorImage = interlocutorImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func sendMessage(text: String) {
        chatService.sendMessage(text: text)
        messages = chatService.loadMessages()
        tableView.reloadData()
        let lastSection = tableView.numberOfSections - 1
        let indexPath = IndexPath(
            row: self.tableView.numberOfRows(inSection: lastSection) - 1,
            section: lastSection
        )
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    // MARK: - Private Methods: View Setup

    private func setupView() {
        view.backgroundColor = Asset.Colors.Chat.TextField.inputAreaBackground.color
        title = interlocutorName
        navigationItem.largeTitleDisplayMode = .never
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(textInputView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textInputView.snp.top)
        }
        textInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages[section].messageGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageGroup = messages[indexPath.section].messageGroups[indexPath.row]
        switch messageGroup.sender {
        case .user:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: messageGroupUserCellReuseIdentifier
            ) as? MessageGroupUserCell else {
                fatalError()
            }
            cell.configure(with: messageGroup)
            return cell
        case .interlocutor:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: messageGroupInterlocutorCellReuseIdentifier
            ) as? MessageGroupInterlocutorCell else {
                fatalError()
            }
            cell.configure(
                with: messageGroup,
                interlocutorImage: interlocutorImage,
                interlocutorName: interlocutorName
            )
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: messageGroupHeaderReuseIdentifier
        ) as? MessageGroupHeader else {
            fatalError("Failed to dequeue header")
        }
        header.configure(with: messages[section].date)
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

// MARK: - KeyboardObserverDelegate

extension ChatViewController: KeyboardObserverDelegate {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double) {
        textInputView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view).inset(keyboardFrame.height)
        }
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    func keyboardWillHide(animationDuration: Double) {
        textInputView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

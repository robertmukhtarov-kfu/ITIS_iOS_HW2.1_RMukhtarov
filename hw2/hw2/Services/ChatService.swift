//
//  ChatService.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import Foundation

final class ChatService {
    private var messagesDB = [
        MessageSection(
            messageGroups: [
                MessageGroup(
                    messages: [
                        "Alex, let’s meet this weekend. I’ll check with Dave too 😎"
                    ],
                    sender: .interlocutor,
                    date: Date(timeIntervalSince1970: 1631640420)
                ),
                MessageGroup(
                    messages: [
                        "Sure. Let’s aim for saturday",
                        "I’m visiting mom this sunday 👻"
                    ],
                    sender: .user,
                    date: Date(timeIntervalSince1970: 1631642160)
                ),
                MessageGroup(
                    messages: [
                        "Alrighty! Will give you a call shortly 🤗"
                    ],
                    sender: .interlocutor,
                    date: Date(timeIntervalSince1970: 1631642460)
                ),
                MessageGroup(
                    messages: [
                        "❤"
                    ],
                    sender: .user,
                    date: Date(timeIntervalSince1970: 1631642640)
                ),
            ],
            date: "SEP 14, 2021"
        ),
        MessageSection(
            messageGroups: [
                MessageGroup(
                    messages: [
                        "Hey you! Are you there?"
                    ],
                    sender: .interlocutor,
                    date: Date(timeIntervalSince1970: 1635929580)
                ),
                MessageGroup(
                    messages: [
                        "👋 Hi Jess! What’s up?"
                    ],
                    sender: .user,
                    date: Date(timeIntervalSince1970: 1635930840)
                )
            ],
            date: "TODAY"
        )
    ]

    func loadMessages() -> [MessageSection] {
        messagesDB
    }

    func sendMessage(text: String) {
        let now = Date()
        let lastSectionIndex = messagesDB.count - 1
        let lastMessageGroupIndex = messagesDB[lastSectionIndex].messageGroups.count - 1
        var lastMessageGroup = messagesDB[lastSectionIndex].messageGroups[lastMessageGroupIndex]
        if Calendar.current.compare(lastMessageGroup.date, to: now, toGranularity: .minute) == .orderedSame {
            lastMessageGroup.messages.append(text)
            messagesDB[lastSectionIndex].messageGroups[lastMessageGroupIndex] = lastMessageGroup
        } else {
            let newGroup = MessageGroup(messages: [text], sender: .user, date: now)
            messagesDB[lastSectionIndex].messageGroups.append(newGroup)
        }
    }
}

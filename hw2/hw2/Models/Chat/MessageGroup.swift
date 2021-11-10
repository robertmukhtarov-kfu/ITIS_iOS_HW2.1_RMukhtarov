//
//  MessageGroup.swift
//  hw2
//
//  Created by RRMukhtarov on 02.11.2021.
//

import Foundation

struct MessageGroup {
    enum Sender {
        case user
        case interlocutor
    }

    var messages: [String]
    let sender: Sender
    let date: Date
}

//
//  ChatListItem.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

struct ChatListItem: Hashable {
    let id = UUID()
    let name: String
    let date: String
    let messagePreview: String
    let image: UIImage?
    
    static let exampleValues = [
        ChatListItem(
            name: "Jessica Thompson",
            date: "4h ago",
            messagePreview: "Hey you! Are u there?",
            image: Asset.Avatars.jessica.image
        ),
        ChatListItem(
            name: "Kat Williams",
            date: "5h ago",
            messagePreview: "OMG! OMG! OMG!",
            image: Asset.Avatars.kat.image
        ),
        ChatListItem(
            name: "Jacob Washington",
            date: "20/9/21",
            messagePreview: "Sure. Sunday works for me!",
            image: Asset.Avatars.jacob.image
        ),
        ChatListItem(
            name: "Leslie Alexander",
            date: "19/9/21",
            messagePreview: "Sent you an invite for next monday.",
            image: nil
        ),
        ChatListItem(
            name: "Tony Monta",
            date: "19/9/21",
            messagePreview: "How’s Alicia doing? Ask her to give me a call, please.",
            image: Asset.Avatars.tony.image
        )
    ]
}

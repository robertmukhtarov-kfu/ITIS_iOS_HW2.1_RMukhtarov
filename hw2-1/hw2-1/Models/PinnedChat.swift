//
//  PinnedChat.swift
//  hw2-1
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

struct PinnedChat: Hashable {
    let id = UUID()
    let name: String
    let image: UIImage?
    
    static let exampleValues = [
        PinnedChat(name: "Kim", image: Asset.Avatars.kim.image),
        PinnedChat(name: "Steve", image: Asset.Avatars.steve.image),
        PinnedChat(name: "Mia", image: Asset.Avatars.mia.image)
    ]
}

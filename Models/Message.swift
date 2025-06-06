//
//  Message.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let senderId: String
    let text: String
    let timestamp: Date
}

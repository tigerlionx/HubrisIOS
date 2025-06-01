//
//  Item.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/1/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

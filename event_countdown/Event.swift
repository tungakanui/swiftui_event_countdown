//
//  Event.swift
//  event_countdown
//
//  Created by Tnui on 7/8/24.
//

import Foundation
import SwiftUI

struct Event: Comparable, Identifiable, Hashable {
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color
    
    init(title: String, date: Date, textColor: Color) {
        self.id = UUID()
        self.title = title
        self.date = date
        self.textColor = textColor
    }
    
    // Comparable protocol conformance
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}


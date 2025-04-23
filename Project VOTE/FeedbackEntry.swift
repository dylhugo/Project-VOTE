//
//  FeedbackEntry.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 23/04/2025.
//

import Foundation

struct FeedbackEntry: Codable, Identifiable {
    var id: UUID = UUID()
    let date: Date
    let scaleResponses: [String: Int]
    let openResponses: [String: String]
}

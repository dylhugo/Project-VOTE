//
//  FeedbackStorage.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 23/04/2025.
//

import Foundation

struct FeedbackStorage {
    static let shared = FeedbackStorage()
    private let filename = "feedback.json"

    func save(entry: FeedbackEntry) {
        var entries = load()
        entries.append(entry)

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let data = try encoder.encode(entries)
            let url = try fileURL()
            try data.write(to: url)
        } catch {
            print(" Failed to save feedback: \(error)")
        }
    }

    func load() -> [FeedbackEntry] {
        do {
            let url = try fileURL()
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([FeedbackEntry].self, from: data)
        } catch {
            return []
        }
    }

    private func fileURL() throws -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(filename)
    }
}

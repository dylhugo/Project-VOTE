//
//  BlockchainManager.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import Foundation

class BlockchainManager: ObservableObject {
    @Published var chain: [Block] = []

    private let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("blockchain.json")

    init() {
        loadBlockchain()
    }

    func addVote(_ vote: String) {
        let previousBlock = chain.last!
        let newIndex = previousBlock.index + 1
        let timestamp = Date()
        let newHash = generateHash(index: newIndex, vote: vote, previousHash: previousBlock.hash, timestamp: timestamp)

        let newBlock = Block(
            id: UUID(),
            index: newIndex,
            timestamp: timestamp,
            vote: vote,
            previousHash: previousBlock.hash,
            hash: newHash
        )

        chain.append(newBlock)
        saveBlockchain()
    }

    func deleteAllVotes() {
        let genesis = Block(id: UUID(), index: 0, timestamp: Date(), vote: "Genesis Block", previousHash: "0", hash: "genesis-hash")
        self.chain = [genesis]
        saveBlockchain()
    }

    private func generateHash(index: Int, vote: String, previousHash: String, timestamp: Date) -> String {
        let combined = "\(index)\(vote)\(previousHash)\(timestamp.timeIntervalSince1970)"
        return String(combined.hashValue)
    }

    private func saveBlockchain() {
        do {
            let data = try JSONEncoder().encode(chain)
            try data.write(to: savePath)
        } catch {
            print("Failed to save blockchain: \(error)")
        }
    }

    private func loadBlockchain() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Block].self, from: data)
            self.chain = decoded
        } catch {
            print("🌀 Starting new chain (no saved blockchain found)")
            let genesis = Block(id: UUID(), index: 0, timestamp: Date(), vote: "Genesis Block", previousHash: "0", hash: "genesis-hash")
            self.chain = [genesis]
        }
    }
}


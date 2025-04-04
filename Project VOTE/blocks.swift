//
//  blocks.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//
import Foundation


struct Block: Identifiable, Codable {
    let id: UUID 
    let index: Int
    let timestamp: Date
    let vote: String
    let previousHash: String
    let hash: String
}


func createBlock(vote: String, previousHash: String, index: Int) -> Block {
    let timestamp = Date()
    let hashInput = "\(vote)\(timestamp)\(previousHash)"
    let hash = String(hashInput.hashValue)

    return Block(id:UUID(),
                 index: index,
                 timestamp: timestamp,
                 vote: vote,
                 previousHash: previousHash,
                 hash: hash)
}



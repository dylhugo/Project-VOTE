//
//  BlockchainAuditView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct BlockchainAuditView: View {
    @ObservedObject var blockchain: BlockchainManager
    @State private var confirmDelete = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("🔗 Blockchain Ledger")
                    .bold()
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                
                ForEach(blockchain.chain) { block in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("🧱 Block #\(block.index)")
                            .font(.headline)
                        Text("Vote: \(block.vote)")
                        Text("Time: \(block.timestamp)")
                        Text("Previous Hash: \(block.previousHash)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Hash: \(block.hash)")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                
            }
        }
    }
}

//
//  FeedbackReviewAndExportView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 23/04/2025.
//

import SwiftUI
import UIKit

struct FeedbackReviewAndExportView: View {
    @State private var entries: [FeedbackEntry] = FeedbackStorage.shared.load()
    @State private var showDeleteAlert = false
    @State private var confirmDeleteVotes = false
    @StateObject private var blockchain = BlockchainManager()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(entries) { entry in
                        Section(header: Text(entry.date.formatted(date: .abbreviated, time: .shortened))) {
                            ForEach(entry.scaleResponses.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                Text("📊 \(key): \(value)")
                            }

                            ForEach(entry.openResponses.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                Text("📝 \(key): \(value)").italic()
                            }
                        }
                    }
                }

                VStack(spacing: 16) {
                    Button("📤 Export All Feedback") {
                        exportFeedbackFile()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("🗑️ Delete All Feedback") {
                        showDeleteAlert = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("🧱 Delete All Votes") {
                        confirmDeleteVotes = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("📂 Feedback Review")
            .alert("Delete all feedback?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    deleteAllFeedback()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This cannot be undone.")
            }
            .alert("Delete all votes?", isPresented: $confirmDeleteVotes) {
                Button("Delete", role: .destructive) {
                    blockchain.deleteAllVotes()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will reset the blockchain to just the genesis block.")
            }
        }
    }

    private func exportFeedbackFile() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("feedback.json") else { return }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(activityVC, animated: true)
        }
    }

    private func deleteAllFeedback() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("feedback.json") else { return }

        try? FileManager.default.removeItem(at: url)
        entries = [] // Update UI
    }
}

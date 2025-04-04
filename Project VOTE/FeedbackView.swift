//
//  FeedbackView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct FeedbackView: View {
    @State private var appFeedback: String = ""
    @State private var blockchainFeedback: String = ""
    @State private var feedbackSubmitted = false
    @StateObject private var blockchain = BlockchainManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Text("📝 Feedback Survey")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Group {
                        Text("1. How do you feel about voting using this app?")
                            .font(.headline)
                            .multilineTextAlignment(.leading)

                        TextEditor(text: $appFeedback)
                            .foregroundColor(.black)
                            .padding(8)
                            .frame(height: 120)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                    }

                    Group {
                        Text("2. What are your thoughts on voting using blockchain?")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        TextEditor(text: $blockchainFeedback)
                            .foregroundColor(.black)
                            .padding(8)
                            .frame(height: 120)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                    }

                    Button("Submit Feedback") {
                        feedbackSubmitted = true
//  save-to-file or send-to-server logic here
                    }
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    if feedbackSubmitted {
                        Text("✅ Thank you for your feedback!")
                            .foregroundColor(.green)
                            .font(.title3)
                            .padding()
                        
                    Spacer()
                    }

                    Spacer()
                    
                }
                .padding()
            }
        }
        NavigationLink(destination: BlockchainAuditView(blockchain: blockchain)) {
            Text("🔗 View Blockchain Ledger")
                .font(.headline)
                .padding()
                .frame(width: 300)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

#Preview {
    FeedbackView()
}

//
//  ConfirmationView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct ConfirmationView: View {
    var selectedParty: String
    @State private var navigateToFeedback = false
    @StateObject private var blockchain = BlockchainManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    Text("Vote Confirmed")
                        .foregroundColor(Color.black)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("You voted for:")
                        .foregroundColor(Color.black)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(selectedParty)
                        .foregroundColor(Color.black)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)

                    VStack(spacing: 16) {
                        NavigationLink(destination: BlockchainAuditView(blockchain: blockchain)) {
                            Text("🔗 View Blockchain Ledger")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: FeedbackView()) {
                            Text("Give Feedback")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top)

                    Spacer()
                }
                .padding()
            }
        }
    }
}


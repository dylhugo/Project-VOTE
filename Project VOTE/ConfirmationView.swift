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

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()
                Text("Vote Confirmed")
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Spacer()
                Text("You voted for:")
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)

                Text(selectedParty)
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Color.gray.opacity(0.3)
                    )
                    .cornerRadius(10)
                
            }
            .padding()
        }
        NavigationLink("Give Feedback", destination: FeedbackView())
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}


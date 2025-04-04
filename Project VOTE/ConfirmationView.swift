//
//  ConfirmationView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct ConfirmationView: View {
    var selectedParty: String

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 30) {
                Text("✅ Vote Confirmed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("You voted for:")
                    .font(.title2)

                Text(selectedParty)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()

                Spacer()
            }
            .padding()
        }
    }
}


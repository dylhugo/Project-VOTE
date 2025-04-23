//
//  ThankYouView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 23/04/2025.
//

import SwiftUI

struct ThankYouView: View {
    @State private var goHome = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("✅ Thank you!")
                .font(.largeTitle)
                .bold()
            Text("Your feedback has been recorded.")
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                goHome = true
            }
        }
        .navigationDestination(isPresented: $goHome) {
            ContentView()
        }
        .padding()
    }
}

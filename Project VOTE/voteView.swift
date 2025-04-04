//
//  voteView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct voteView: View {
    @State private var selectedVote: String? = nil
    @State private var voteSubmitted = false
    
    let options = ["Center-Right Parties", "Center-Left Parties", "Right-wing Parties", "Left-wing Parties", "Green Parties", "Change parties"]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                Text("Vote for your choice")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        self.selectedVote = option
                    }) {
                        Text(option)
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                selectedVote == option ? getColor(for: option) : Color.gray.opacity(0.3)
                            )
                            .cornerRadius(10)
                    }
                    .frame(width: 300)
                }
                
                if let _ = selectedVote {
                    Button("Submit Vote") {
                        voteSubmitted = true
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if voteSubmitted, let vote = selectedVote {
                    Text("✅ You voted for \(vote)")
                        .foregroundColor(.green)
                        .font(.title3)
                        .padding(.top)
                }
                
                Spacer()
            }
            .padding()
        }
    }

    // ✅ Fixed color function
    func getColor(for selection: String) -> Color {
        switch selection {
        case "Center-Right Parties": return Color.gray
        case "Center-Left Parties": return Color.gray
        case "right-wing Parties": return Color.gray
        case "left-wing Parties": return Color.gray
        case "Green Parties": return Color.gray
        case "Change parties": return Color.gray
        default: return Color.gray
        }
    }
}

#Preview {
    voteView()
}

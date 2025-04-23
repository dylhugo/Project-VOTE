//
//  FeedbackView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct FeedbackView: View {
    @State private var scaleResponses: [UUID: Int] = [:]
    @State private var openResponses: [UUID: String] = [:]
    @State private var feedbackSubmitted = false
    @StateObject private var blockchain = BlockchainManager()

    struct FeedbackQuestion: Identifiable {
        let id = UUID()
        let text: String
        let section: String
    }

    struct OpenEndedQuestion: Identifiable {
        let id = UUID()
        let text: String
    }

    // Questions
    let scaleQuestions: [FeedbackQuestion] = [
        
// Section A
        FeedbackQuestion(text: "The voting system was easy to navigate.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I was able to understand what to do without external instructions.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "The voting process took an appropriate amount of time.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I experienced no technical difficulties while using the system.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I believe someone with little technical knowledge could use this system.", section: "Usability & Accessibility"),

// Section B
        FeedbackQuestion(text: "I felt confident that my vote was anonymous.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "I was aware of how my data would be handled during and after voting.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "The system gave me the impression that it could withstand tampering or hacking.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "I believe this system could be safely used in a real election scenario.", section: "Privacy & Security Perception"),

// Section C
        FeedbackQuestion(text: "I could verify that my vote had been recorded correctly.", section: "Transparency & Trust"),
        FeedbackQuestion(text: "The system gave enough feedback (e.g., confirmations or receipts) to build trust.", section: "Transparency & Trust"),
        FeedbackQuestion(text: "I understood how the system keeps votes secure without revealing identities.", section: "Transparency & Trust"),

// Section D
        FeedbackQuestion(text: "I trust this system more than traditional paper-based voting.", section: "Comparative View"),
        FeedbackQuestion(text: "I trust this system more than existing electronic voting systems (if you’ve used any).", section: "Comparative View")
    ]

    let openEndedQuestions: [OpenEndedQuestion] = [
        OpenEndedQuestion(text: "What aspects of the system made you feel confident or concerned about using it?"),
        OpenEndedQuestion(text: "What additional features would improve your trust or experience using the system?"),
        OpenEndedQuestion(text: "Would you be comfortable using this system in a real election? Why or why not?")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("📝 Feedback Survey")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    ForEach(Array(Dictionary(grouping: scaleQuestions, by: \.section)), id: \.key) { section, questions in
                        Section(header: Text(section).font(.headline)) {
                            ForEach(questions) { question in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(question.text)
                                        .font(.subheadline)

                                    Picker("Answer", selection: Binding<Int?>(
                                        get: { scaleResponses[question.id] },
                                        set: { scaleResponses[question.id] = $0 }
                                    )) {
                                        ForEach(1...5, id: \.self) { value in
                                            Text("\(value)").tag(value as Int?)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }

                    Section(header: Text("Open-Ended Feedback").font(.headline)) {
                        ForEach(openEndedQuestions) { question in
                            VStack(alignment: .leading) {
                                Text(question.text)
                                    .font(.subheadline)

                                TextEditor(text: Binding<String>(
                                    get: { openResponses[question.id, default: ""] },
                                    set: { openResponses[question.id] = $0 }
                                ))
                                .foregroundColor(.black)
                                .frame(height: 100)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                            }
                            .padding(.bottom, 10)
                        }
                    }

                    Button("Submit Feedback") {
                        feedbackSubmitted = true
                        // 🔒 Save to blockchain or backend here
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    if feedbackSubmitted {
                        Text("✅ Thank you for your feedback!")
                            .foregroundColor(.green)
                            .font(.title3)
                            .padding(.top)
                    }

                    NavigationLink(destination: BlockchainAuditView(blockchain: blockchain)) {
                        Text("🔗 View Blockchain Ledger")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    FeedbackView()
}

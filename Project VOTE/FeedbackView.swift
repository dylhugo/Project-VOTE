//
//  FeedbackView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 04/04/2025.
//

import SwiftUI

struct FeedbackView: View {
    @State private var scaleResponses: [String: Int] = [:]
    @State private var openResponses: [String: String] = [:]
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

    let sectionOrder = [
        "Usability & Accessibility",
        "Privacy & Security Perception",
        "Transparency & Trust",
        "Comparative View"
    ]

    let scaleQuestions: [FeedbackQuestion] = [
        FeedbackQuestion(text: "The voting system was easy to navigate.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I was able to understand what to do without external instructions.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "The voting process took an appropriate amount of time.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I experienced no technical difficulties while using the system.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I believe someone with little technical knowledge could use this system.", section: "Usability & Accessibility"),
        FeedbackQuestion(text: "I felt confident that my vote was anonymous.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "I was aware of how my data would be handled during and after voting.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "The system gave me the impression that it could withstand tampering or hacking.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "I believe this system could be safely used in a real election scenario.", section: "Privacy & Security Perception"),
        FeedbackQuestion(text: "I could verify that my vote had been recorded correctly.", section: "Transparency & Trust"),
        FeedbackQuestion(text: "The system gave enough feedback (e.g., confirmations or receipts) to build trust.", section: "Transparency & Trust"),
        FeedbackQuestion(text: "I understood how the system keeps votes secure without revealing identities.", section: "Transparency & Trust"),
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
                LazyVStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("📝 Feedback Survey")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        // Spacer between title and explanation
                        Text("1 = Strongly Disagree  5 = Strongly Agree")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)


                    ForEach(sectionOrder, id: \.self) { section in
                        renderScaleSection(for: section)
                    }

                    openEndedSection

                    Button("Submit Feedback") {
                        let entry = FeedbackEntry(
                            date: Date(),
                            scaleResponses: scaleResponses,
                            openResponses: openResponses
                        )

                        FeedbackStorage.shared.save(entry: entry)
                        feedbackSubmitted = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    NavigationLink(destination: BlockchainAuditView(blockchain: blockchain)) {
                        Text("🔗 View Blockchain Ledger")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationDestination(isPresented: $feedbackSubmitted) {
                ThankYouView()
            }
        }
    }

    private func renderScaleSection(for section: String) -> some View {
        Section(header: Text(section).font(.headline)) {
            ForEach(scaleQuestions.filter { $0.section == section }) { question in
                GroupBox {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(question.text)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)

                        Picker("Answer", selection: Binding<Int?>(
                            get: { scaleResponses[question.text] },
                            set: { scaleResponses[question.text] = $0 }
                        )) {
                            ForEach(1...5, id: \.self) { value in
                                Text("\(value)").tag(value as Int?)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: scaleResponses[question.text])
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }

    private var openEndedSection: some View {
        Section(header: Text("Open-Ended Feedback").font(.headline)) {
            ForEach(openEndedQuestions) { question in
                GroupBox {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(question.text)
                            .font(.subheadline)

                        TextEditor(text: Binding<String>(
                            get: { openResponses[question.text, default: ""] },
                            set: { openResponses[question.text] = $0 }
                        ))
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3))
                        )
                    }
                }
            }
        }
    }
}

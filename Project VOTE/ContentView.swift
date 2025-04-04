//
//  ContentView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 03/04/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var codeEntered: String = ""
    @State private var registrationCode: String = ""
    @State private var navigateToVote = false
    @State private var errorMessage: String? = nil
    let validRegistrationCodes = ["123123","321321"]
    let validSecureCodes = ["123456","654321"]
    
    
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Please enter confirmation code below")
                        .foregroundColor(Color.black)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                   
                    Text("Enter Registration Code")
                        .foregroundColor(Color.black)
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                    ZStack(alignment: .leading){
                        if registrationCode.isEmpty {
                            Text("Enter Registration Code")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 15)
                                .multilineTextAlignment(.center)
                            
                        }
                        TextField("", text: $registrationCode)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 300, height: 50)
                            .keyboardType(.numberPad)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    Text("Enter 6 digit code")
                        .foregroundColor(Color.black)
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    ZStack(alignment: .leading) {
                        if codeEntered.isEmpty {
                            Text("6 digit code")
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                                .multilineTextAlignment(.center)
                        }
                        
                        SecureField("", text: $codeEntered)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 300, height: 50)
                            .keyboardType(.numberPad)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .autocorrectionDisabled(true)
                            .submitLabel(.done)
                            .onSubmit {
                                codeEntered = String(codeEntered.filter { $0.isNumber }.prefix(6))
                            }
                    }
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button("Confirm") {
                        let reg = registrationCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
                        let secure = codeEntered.filter { $0.isNumber }
                        
                        if validRegistrationCodes.contains(reg) && validSecureCodes.contains(secure) {
                            navigateToVote = true
                            errorMessage = nil
                        } else {
                            errorMessage = "Invalid registration or confirmation code."
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
                .padding()
            }
                .navigationDestination(isPresented: $navigateToVote) {
                    voteView()
                }
            }
        }
    }

#Preview {
    FeedbackView()
}

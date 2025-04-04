//
//  ContentView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 03/04/2025.
//

import SwiftUI


struct ContentView: View {
    
    @State private var codeEntered: String = ""
    @State private var navigateToVote = false
    
    var body: some View {
        
//Stack for main text
            VStack {
                Spacer()
                
                Text("please enter confimation code's below")
                    .font(.title)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            
// stack for code entry
            VStack {
                Text("Enter Registration Code")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                
                TextField("**** **** ****", text: .constant(""))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 300, height: 50)
                    .keyboardType(.numberPad)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                
                Spacer()
                
                Text("Enter 6 digit code")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                
                SecureField("6 didget code", text: $codeEntered).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 300, height: 50)
                    .keyboardType(.numberPad)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                
                
// confirm button
                Spacer()
                
                Button("Confirm") {
                        let filtered = codeEntered.filter { $0.isNumber }
                        codeEntered = String(filtered.prefix(6))
                        
                        if codeEntered.count < 6 {
                            print("Code too short!")
                        } else {
                            print("Submitted code: \(codeEntered)")
                            navigateToVote = true
                        }
                }
 // hidden navagation link
                .navigationDestination(isPresented: $navigateToVote) {
                                voteView()
                }
                
                Spacer()
            }
    }
}

// end



#Preview {
    ContentView()
}

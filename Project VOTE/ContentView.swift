//
//  ContentView.swift
//  Project VOTE
//
//  Created by Dylan Hughes on 03/04/2025.
//

import SwiftUI


struct ContentView: View {
    
    @State private var codeEntered: String = ""
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
            
            // stact for code entry
            VStack {
                Text("Enter Registration Code")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                
                TextField("", text: .constant(""))
                    .padding()
                    .frame(width: 300, height: 50)
                    .keyboardType(.numberPad)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                
                Spacer()
                
                Text("Enter 6 digit code")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                
                SecureField("6 didget code", text: $codeEntered)
                    .padding()
                    .frame(width: 300, height: 50)
                    .keyboardType(.numberPad)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                
                
                
                Spacer()
                
                Button("Confirm") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Spacer()
            }
            
            
            
            // end
        
    }
}





#Preview {
    ContentView()
}

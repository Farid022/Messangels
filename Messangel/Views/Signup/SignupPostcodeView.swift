//
//  SignupPostcodeView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import Combine

struct SignupPostcodeView: View {
    @State private var progress = 12.5 * 2
    @State private var valid = false
    @ObservedObject var userVM: UserViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupGenderView(userVM: userVM)), currentView: "SignupPostcodeView", footer: AnyView(MyLink(url: "https://www.google.com", text: "Politique de confidentialité"))) {
            Text("Indiquez votre code postal actuel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            TextField("", text: $userVM.user.postal_code)
                .keyboardType(.numberPad)
                .textContentType(.postalCode)
                .focused($isFocused)
//                .overlay(HStack {
//                    Spacer()
//                    Image("ic_checkmark")
//                        .foregroundColor(.accentColor)
//                        .padding(.trailing, 20)
//                        .opacity(valid ? 1 : 0)
//                        .animation(.default)
//                })
                .onReceive(Just(userVM.user.postal_code)) { inputValue in
                    if inputValue.count > 5 {
                        userVM.user.postal_code.removeLast()
                    }
                }
        }
        .onDidAppear {
            isFocused = true
            self.validate()
        }
        .onChange(of: userVM.user.postal_code) { value in
            self.validate()
            if valid {
                isFocused = false
            }
        }
    }
    
    private func validate() {
        self.valid = userVM.user.postal_code.count == 5
    }
}

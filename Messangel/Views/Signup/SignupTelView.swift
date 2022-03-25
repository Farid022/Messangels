//
//  SignupTelView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import Combine

struct SignupTelView: View {
    @ObservedObject var userVM: UserViewModel
    @State private var progress = 12.5 * 6
    @State private var valid = false
    @State private var editing = true
    @State private var phone_number = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupCodeView(userVM: userVM)), currentView: "SignupTelView", footer: AnyView(MyLink(url: "https://www.google.com", text: "Politique de confidentialité"))) {
            Text("Mon numéro de téléphone mobile")
                .font(.system(size: 22))
                .fontWeight(.bold)
            TextField("Numéro de téléphone", text: $phone_number)
                .keyboardType(.numberPad)
                .textContentType(.telephoneNumber)
                .focused($isFocused)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .onReceive(Just(phone_number)) { inputValue in
                    if inputValue.count > 17 {
                        phone_number.removeLast()
                    }
                }
        }
        .onDidAppear {
            isFocused = true
        }
        .onChange(of: phone_number) { value in
            phone_number = value.applyPatternOnNumbers(pattern: "## ## ## ## ## ##", replacmentCharacter: "#")
            self.validate()
            if valid {
                isFocused = false
            }
        }
    }
    
    private func validate() {
        userVM.user.phone_number = phone_number.replacingOccurrences(of: " ", with: "")
        valid = userVM.user.phone_number.count == 10 || userVM.user.phone_number.count == 12
    }
}

extension String {

    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

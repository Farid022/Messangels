//
//  SignupNameView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUIX

struct SignupNameView: View {
    @StateObject private var userVM = UserViewModel()
    @State private var referralCode: String = ""
    @State private var referral = false
    @State private var progress = 1.0
    @State private var valid = false
    @State private var editing = true
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupBirthView(userVM: userVM)), currentView: "SignupNameView", footer: AnyView(Text("Veuillez saisir votre vrai nom, sans utiliser\nde pseudonyme.").font(.system(size: 13)))) {
            Text("Je m’appelle…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            CocoaTextField("Prénom", text: $userVM.user.first_name)
                .isInitialFirstResponder(true)
                .xTextFieldStyle()
            CocoaTextField("Nom", text: $userVM.user.last_name) 
                .xTextFieldStyle()
            Toggle(isOn: $referral) {
                Text("J’ai un code filleul")
                    .font(.system(size: 13))
            }.toggleStyle(CheckboxToggleStyle())
            if referral {
                TextField("Code filleul", text: $referralCode)
            }
        }
        .onChange(of: userVM.user.first_name) { value in
            self.validate()
        }
        .onChange(of: userVM.user.last_name) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = !userVM.user.first_name.isEmpty && !userVM.user.last_name.isEmpty
    }
}

struct SignupNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignupNameView()
    }
}

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
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupBirthView(userVM: userVM)), currentView: "SignupNameView", footer: AnyView(Text("Veuillez saisir votre vrai nom, sans utiliser de pseudonyme.").font(.system(size: 13)))) {
            Text("Je m’appelle…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            CocoaTextField("Sophie", text: $userVM.user.first_name) { isEditing in
                self.editing = isEditing
            } onCommit:  {
                self.editing = false
            }
            .isInitialFirstResponder(true)
            .xTextFieldStyle()
            TextField("Nom", text: $userVM.user.last_name) { isEditing in
                self.editing = isEditing
            } onCommit:  {
                self.editing = false
            }
            if referral {
                TextField("Code filleul", text: $referralCode)
            } else {
                Toggle(isOn: $referral) {
                    Text("J’ai un code filleul")
                        .font(.system(size: 13))
                }.toggleStyle(CheckboxToggleStyle())
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

//struct SignupNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupNameView()
//    }
//}

//
//  SignupNameView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUI

struct SignupNameView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var referralCode: String = ""
    @State private var referral = false
    @State private var progress = 1.0
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupBirthView()), footer: AnyView(Text("Veuillez saisir votre vrai nom, sans utiliser de pseudonyme."))) {
            Text("Je m’appelle…")
                .font(.headline)
            TextField("Sophie", text: $firstName)
            TextField("Nom", text: $lastName, onCommit:  {
                valid = true
            })
            if referral {
                TextField("Code filleul", text: $referralCode)
            } else {
                Toggle(isOn: $referral) {
                    Text("J’ai un code filleul")
                }.toggleStyle(CheckboxToggleStyle())
            }
        }
    }
}

struct SignupNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignupNameView()
    }
}

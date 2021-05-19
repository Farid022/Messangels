//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormConfirmEmailView: View {
    @State private var progress = (100/7)*4.0
    @State private var valid = false
    @State private var confirmEmail = ""
    
    var body: some View {
        GuardianFormBaseView(title: "Confirmez l’adresse mail" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormLegalAgeView())) {
            TextField("Confirmer mail", text: $confirmEmail, onCommit:  {
                valid = true
            })
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
    }
}

struct GuardianFormConfirmEmailView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormConfirmEmailView()
    }
}

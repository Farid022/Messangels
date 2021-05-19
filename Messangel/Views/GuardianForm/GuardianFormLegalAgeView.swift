//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormLegalAgeView: View {
    @State private var progress = (100/7)*5.0
    @State private var valid = false
    @State private var confirmEmail = ""
    
    var body: some View {
        GuardianFormBaseView(title: "Confirmez que cette personne est majeure" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormNoteView())) {
            TextField("Cette personne est majeure", text: $confirmEmail, onCommit:  {
                valid = true
            })
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
    }
}

struct GuardianFormLegalAgeView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormLegalAgeView()
    }
}

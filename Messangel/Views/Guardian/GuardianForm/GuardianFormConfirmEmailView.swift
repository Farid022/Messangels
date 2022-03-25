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
    @ObservedObject var vm: GuardianViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GuardianFormBaseView(title: "Confirmez l’adresse mail" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormLegalAgeView(vm: vm))) {
            TextField("Confirmer mail", text: $confirmEmail)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .submitLabel(.next)
                .textContentType(.emailAddress)
                .normalShadow()
        }
        .onChange(of: confirmEmail) { value in
            valid = confirmEmail == vm.guardian.email
        }
        .onDidAppear {
            isFocused = true
        }
    }
}

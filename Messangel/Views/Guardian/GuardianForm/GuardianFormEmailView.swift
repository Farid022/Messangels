//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import Peppermint

struct GuardianFormEmailView: View {
    @State private var progress = (100/7)*3.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    @FocusState private var isFocused: Bool
    let predicate = EmailPredicate()
    
    var body: some View {
        GuardianFormBaseView(title: "Adresse mail" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormConfirmEmailView(vm: vm))) {
            TextField("Mail", text: $vm.guardian.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .submitLabel(.next)
                .textContentType(.emailAddress)
                .normalShadow()
        }
        .onChange(of: vm.guardian.email) { value in
            valid = predicate.evaluate(with: value)
        }
        .onDidAppear {
            isFocused = true
        }
    }
}

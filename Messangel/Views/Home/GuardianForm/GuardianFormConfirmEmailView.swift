//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUIX

struct GuardianFormConfirmEmailView: View {
    @State private var progress = (100/7)*4.0
    @State private var valid = false
    @State private var confirmEmail = ""
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Confirmez l’adresse mail" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormLegalAgeView(vm: vm))) {
            CocoaTextField("Confirmer mail", text: $confirmEmail)
            .isFirstResponder(true)
            .xTextFieldStyle()
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
        .onChange(of: confirmEmail) { value in
            valid = confirmEmail == vm.guardian.email
        }
    }
}

//struct GuardianFormConfirmEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormConfirmEmailView()
//    }
//}

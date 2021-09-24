//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUIX

struct GuardianFormEmailView: View {
    @State private var progress = (100/7)*3.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Adresse mail" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormConfirmEmailView(vm: vm))) {
            CocoaTextField("Mail", text: $vm.guardian.email, onCommit:  {
                valid = true
            })
//            .isFirstResponder(true)
            .xTextFieldStyle()
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
    }
}

//struct GuardianFormEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormEmailView()
//    }
//}

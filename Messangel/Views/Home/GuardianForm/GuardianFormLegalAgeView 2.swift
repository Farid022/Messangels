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
    @ObservedObject var vm: GuardianViewModel
    var body: some View {
        GuardianFormBaseView(title: "Confirmez que cette personne est majeure" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormNoteView(vm: vm))) {
            Button("Cette personne est majeure") {
                valid.toggle()
            }
            .buttonStyle(MyButtonStyle(padding: 0, foregroundColor: valid ? .white : .black, backgroundColor: valid ? .accentColor : .white))
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
    }
}

//struct GuardianFormLegalAgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormLegalAgeView()
//    }
//}

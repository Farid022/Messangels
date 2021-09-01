//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUIX

struct GuardianFormFirstNameView: View {
    @State private var progress = (100/7)*2.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Prénom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormEmailView(vm: vm))) {
            CocoaTextField("Prénom", text: $vm.guardian.first_name, onCommit:  {
                valid = true
            })
            .isFirstResponder(true)
            .xTextFieldStyle()
            .shadow(color: .gray.opacity(0.3), radius: 10)
        }
    }
}

//struct GuardianFormFirstNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormFirstNameView()
//    }
//}

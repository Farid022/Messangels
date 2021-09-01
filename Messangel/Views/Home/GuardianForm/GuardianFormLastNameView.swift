//
//  GuardianFormLastNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUIX

struct GuardianFormLastNameView: View {
    @State private var progress = 1.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Nom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormFirstNameView(vm: vm))) {
            CocoaTextField("Nom", text: $vm.guardian.last_name, onCommit:  {
                valid = true
            })
            .isFirstResponder(true)
            .xTextFieldStyle()
            .shadow(color: .gray.opacity(0.3), radius: 10)
        }
    }
}

//struct GuardianFormLastNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormLastNameView()
//    }
//}

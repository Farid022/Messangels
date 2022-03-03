//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormFirstNameView: View {
    @State private var progress = (100/7)*2.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GuardianFormBaseView(title: "Prénom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormEmailView(vm: vm))) {
            TextField("Prénom", text: $vm.guardian.first_name)
                .textContentType(.givenName)
                .focused($isFocused)
                .submitLabel(.next)
                .normalShadow()
        }
        .onChange(of: vm.guardian.first_name) { value in
            valid = !value.isEmpty
        }
        .onDidAppear {
            isFocused = true
        }
    }
}

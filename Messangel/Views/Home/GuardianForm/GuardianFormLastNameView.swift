//
//  GuardianFormLastNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormLastNameView: View {
    @State private var progress = 1.0
    @State private var valid = false
    @FocusState private var isFocused: Bool
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Nom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormFirstNameView(vm: vm))) {
            TextField("Nom", text: $vm.guardian.last_name)
                .textContentType(.familyName)
                .focused($isFocused)
                .submitLabel(.next)
                .normalShadow()
        }
        .onChange(of: vm.guardian.last_name) { value in
            valid = !value.isEmpty
        }
        .onDidAppear {
            isFocused = true
        }
    }
}

//
//  KeyAccRegEmailView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI

struct KeyAccRegEmailView: View {
    var keyAccCase: KeyAccCase
    @StateObject var vm = KeyAccViewModel()
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "Indiquez une adresse email principale", valid: .constant(!vm.keyEmailAcc.email.isEmpty), destination: AnyView(KeyAccRegPasswordView(keyAccCase: keyAccCase, vm: vm))) {
            TextField("prenom@mail.com", text: $vm.keyEmailAcc.email)
                .keyboardType(.emailAddress)
                .normalShadow()
        }
    }
}

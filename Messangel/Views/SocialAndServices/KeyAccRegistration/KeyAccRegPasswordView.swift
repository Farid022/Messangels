//
//  KeyAccRegPasswordView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI

struct KeyAccRegPasswordView: View {
    @State private var conformPassword = ""
    @State private var hidePassword = true
    @State private var valid = false
    var keyAccCase: KeyAccCase
    @ObservedObject var vm: KeyAccViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "\(vm.keyEmailAcc.email) - Saisissez le mot de passe de ce compte", valid: .constant(true), destination: AnyView(KeyAccRegChoiceView(vm: vm, keyAccCase: keyAccCase))) {
            
            Group {
                MyTextField(placeholder: "Mot de passe", text: $vm.keyEmailAcc.password, isSecureTextEntry: $hidePassword)
                MyTextField(placeholder: "Confirmez mot de passe", text: $conformPassword, isSecureTextEntry: $hidePassword)
            }
            .xTextFieldStyle()
            .normalShadow()
            .overlay(HStack {
                Spacer()
                Image(systemName: hidePassword ? "eye" : "eye.slash")
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                    .animation(.default, value: hidePassword)
                    .onTapGesture {
                        hidePassword.toggle()
                    }
            })
            Spacer()
                .frame(height: 50)
            Text("Rappel : l’ensemble des données Messangel sont sécurisées. Consultez notre politique de confidentialité en cliquant ici.")
                .foregroundColor(.secondary)
        }
//        .onChange(of: password) { value in
//            self.validate()
//        }
//        .onChange(of: conformPassword) { value in
//            self.validate()
//        }
    }
//    private func validate() {
//        self.valid = password.count >= 8 && password == conformPassword
//    }
}

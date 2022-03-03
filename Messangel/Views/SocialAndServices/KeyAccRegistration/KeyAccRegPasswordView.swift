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
    @FocusState private var focusedField: PasswordField?
    
    enum PasswordField {
        case password
        case confirmPassword
    }
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "\(vm.keyEmailAcc.email) - Saisissez le mot de passe de ce compte", valid: .constant(!vm.keyEmailAcc.password.isEmpty && vm.keyEmailAcc.password == conformPassword), destination: AnyView(KeyAccRegChoiceView(vm: vm, keyAccCase: keyAccCase))) {
            
            Group {
                MyTextField(placeholder: "Mot de passe", text: $vm.keyEmailAcc.password, isSecureTextEntry: $hidePassword) {
                    focusedField = .confirmPassword
                }
                .focused($focusedField, equals: .password)
                MyTextField(placeholder: "Confirmez mot de passe", text: $conformPassword, isSecureTextEntry: $hidePassword) {
                    hideKeyboard()
                }
                .focused($focusedField, equals: .confirmPassword)
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
        .onDidAppear {
            focusedField = .password
        }
    }
}

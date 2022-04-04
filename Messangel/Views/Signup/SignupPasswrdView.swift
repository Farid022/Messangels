//
//  SignupPasswrdView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import NavigationStack

struct SignupPasswrdView: View {
    enum PasswordField {
        case password
        case confirmPassword
    }
    
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var userVM: UserViewModel
    @State private var conformPassword: String = ""
    @State private var progress = 12.5 * 5
    @State private var valid = false
    @State private var hidePassword = true
    @FocusState private var focusedField: PasswordField?
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView(userVM: userVM)), currentView: "SignupPasswrdView", footer: AnyView(Spacer())) {
            Text("Mot de passe Messangel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            Group {
                MyTextField(placeholder: "Mot de passe", text: $userVM.user.password.bound, isSecureTextEntry: $hidePassword) {
                    focusedField = .confirmPassword
                }
                .focused($focusedField, equals: .password)
                MyTextField(placeholder: "Confirmez mot de passe", text: $conformPassword, isSecureTextEntry: $hidePassword) {
                    hideKeyboard()
                }
                .focused($focusedField, equals: .confirmPassword)
            }
            .xTextFieldStyle()
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
            Text(userVM.user.password?.count ?? 0 < 8 ? "Sécurité : Insuffisant" : "✓ Sécurité : Bon")
                .font(.system(size: 13))
                .padding(.leading)
        }
        .onDidAppear {
            focusedField = .password
        }
        .onChange(of: userVM.user.password) { value in
            self.validate()
        }
        .onChange(of: self.conformPassword) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.password?.count ?? 0 >= 8 && userVM.user.password == self.conformPassword
    }
}

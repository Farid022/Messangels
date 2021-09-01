//
//  SignupPasswrdView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX

struct SignupPasswrdView: View {
    @ObservedObject var userVM: UserViewModel
    @State private var conformPassword: String = ""
    @State private var progress = 12.5 * 5
    @State private var valid = false
    @State private var editing = true
    
    var body: some View {
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView(userVM: userVM)), currentView: "SignupPasswrdView", footer: AnyView(Text(""))) {
            Text("Mot de passe Messangel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
                .font(.system(size: 15))
            CocoaTextField("Mot de passe", text: $userVM.user.password) { isEditing in
                self.editing = isEditing
            }
            .isInitialFirstResponder(true)
            .secureTextEntry(true)
            .xTextFieldStyle()
            CocoaTextField("Mot de passe", text: $conformPassword) { isEditing in
                self.editing = isEditing
            }
            .secureTextEntry(true)
            .xTextFieldStyle()
            Text(userVM.user.password!.count < 8 ? "Sécurité : Insuffisant" : "✓ Sécurité : Bon")
                .font(.system(size: 13))
                .padding(.leading)
        }
        .onChange(of: userVM.user.password) { value in
            self.validate()
        }
        .onChange(of: self.conformPassword) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.password!.count >= 8 && userVM.user.password! == self.conformPassword
    }
}

//struct SignupPasswrdView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupPasswrdView()
//    }
//}

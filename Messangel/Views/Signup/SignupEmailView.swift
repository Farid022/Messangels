//
//  SignupEmailView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX

struct SignupEmailView: View {
    @ObservedObject var userVM: UserViewModel
    @State private var progress = 12.5 * 4
    @State private var valid = false
    @State private var editing = true
    @State private var accept = false
    
    var body: some View {
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupPasswrdView(userVM: userVM)), currentView: "SignupEmailView", footer: AnyView(Text(""))) {
            Text("Mon e-mail")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Un e-mail sera envoyé à cette adresse pour la confirmer.")
                .font(.system(size: 15))
            CocoaTextField("Mon adresse e-mail", text: $userVM.user.email) { isEditing in
                self.editing = isEditing
            } onCommit: {}
                .isFirstResponder(true)
                .keyboardType(.emailAddress)
                .xTextFieldStyle()
            Toggle(isOn: $accept) {
                Text("J’accepte les conditions générales d’utilisation de mes données en conformité avec les normes européennes RGPD en vigueur. Lire")
                    .font(.system(size: 13))
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.trailing, -10)
            .onChange(of: accept) { value in
                self.validate()
            }
        }
        .onChange(of: userVM.user.email) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = !userVM.user.email.isEmpty && self.accept
    }
}

//struct SignupEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupEmailView()
//    }
//}

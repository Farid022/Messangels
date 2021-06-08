//
//  SignupPasswrdView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupPasswrdView: View {
    @State private var password: String = ""
    @State private var conformPassword: String = ""
    @State private var progress = 12.5 * 5
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView()), currentView: "SignupPasswrdView", footer: AnyView(Text(""))) {
            Text("Mot de passe Messangel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
                .font(.system(size: 15))
            SecureField("Mot de passe", text: $password) {
                
            }
            SecureField("Mot de passe", text: $conformPassword) {
                valid = true
            }
            Text("Sécurité : Insuffisant")
                .font(.system(size: 13))
                .padding(.leading)
        }
    }
}

struct SignupPasswrdView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPasswrdView()
    }
}

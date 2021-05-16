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
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView()), footer: AnyView(Text(""))) {
            Text("Mot de passe Messangel")
                .font(.title2)
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
            SecureField("Mot de passe", text: $password) {
                
            }
            SecureField("Mot de passe", text: $conformPassword) {
                valid = true
            }
            Text("Sécurité : Insuffisant")
                .font(.caption)
                .padding(.leading)
        }
    }
}

struct SignupPasswrdView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPasswrdView()
    }
}

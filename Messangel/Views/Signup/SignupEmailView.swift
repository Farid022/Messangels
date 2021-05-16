//
//  SignupEmailView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupEmailView: View {
    @State private var firstName: String = ""
    @State private var progress = 12.5 * 4
    @State private var valid = false
    @State private var accept = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupPasswrdView()), footer: AnyView(Text(""))) {
            Text("Mon e-mail")
                .font(.title2)
                .fontWeight(.bold)
            Text("Un e-mail sera envoyé à cette adresse pour la confirmer.")
            TextField("Mon adresse e-mail", text: $firstName, onCommit: {})
                .keyboardType(.emailAddress)
            Toggle(isOn: $accept) {
                Text("J’accepte les conditions générales d’utilisation de mes données en conformité avec les normes européennes RGPD en vigueur. Lire")
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.trailing, -10)
            .onChange(of: accept) { value in
                if accept && progress == 12.5 * 5 {
                    valid = true
                }
            }
        }
    }
}

struct SignupEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignupEmailView()
    }
}

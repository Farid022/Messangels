//
//  LoginView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var auth: AuthState
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    BackButton(viewId: StartView.id)
                    Spacer()
                }
                Spacer()
                Image("logo")
                Text("Connectez-vous")
                    .padding(.bottom)
                TextField("Identifiant ou adresse mail", text: $username)
                SecureField("Mot de passe", text: $password)
                HStack {
                    Spacer()
                    Text("Mot de passe oublié ?")
                        .font(.subheadline)
                        .underline()
                }
                .padding(.bottom, 50)
                Button("Connexion", action: {
                    withAnimation {
                        self.auth.user = true
                    }
                })
                .buttonStyle(MyButtonStyle())
                .padding(.bottom, 50)
                
                Link(destination: URL(string: "https://www.google.com")!, label: {
                    Text("Politique de confidentialité")
                        .underline()
                })
                Spacer()
            }
            .padding()
        }
        .textFieldStyle(MyTextFieldStyle())
        .foregroundColor(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

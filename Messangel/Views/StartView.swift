//
//  SplashView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI

struct StartView: View {
    @State private var logoOffset: CGFloat = 0.0
    private var welcomeText = """
    Bienvenue.
    Inscrivez-vous ou connectez-vous
    à votre compte Messangel.
    """
    
    var body: some View {
        GeometryReader { g in
            NavigationView {
                ZStack {
                    Color.accentColor
                        .ignoresSafeArea()
                    VStack(spacing: 20) {
                        Image("logo")
                            .offset(y: logoOffset)
                            .onAppear{
                                DispatchQueue.main.async {
                                    withAnimation {
                                        logoOffset = -80
                                    }
                                }
                            }
                        Text(welcomeText)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        NavigationLink(destination: SignupIntroView()) {
                            Text("Créer un compte")
                                .foregroundColor(.black)
                        }
                        NavigationLink(destination: LoginView()) {
                            Text("Se connecter")
                        }
                        Link(destination: URL(string: "https://www.google.com")!, label: {
                            Text("Politique de confidentialité")
                                .underline()
                        })
                        .buttonStyle(DefaultButtonStyle())
                        .padding(.top, 100)
                    }
                    .buttonStyle(MyButtonStyle())
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            StartView()
        }
    }
}

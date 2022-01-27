//
//  SplashView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI
import NavigationStack

struct StartView: View {
    static let id = String(describing: Self.self)
    @EnvironmentObject var navigationModel: NavigationModel
    
    @State private var logoOffset: CGFloat = 50.0
    private var welcomeText = """
    Bienvenue.
    Inscrivez-vous ou connectez-vous
    à votre compte Messangel.
    """
    
    var body: some View {
        NavigationStackView(StartView.id) {
                ZStack {
                    Color.accentColor
                        .ignoresSafeArea()
                    VStack(spacing: 20) {
                        Spacer()
                        Image("logo")
                            .offset(y: logoOffset)
                            .onAppear{
                                DispatchQueue.main.async {
                                    withAnimation {
                                        logoOffset = -50
                                    }
                                }
                            }
                        Text(welcomeText)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        Button(action: {
                            navigationModel.pushContent(StartView.id) {
                                SignupIntroView()
                            }
                        }) {
                            Text("Créer un compte")
                                .foregroundColor(.black)
                        }
                        Button(action: {
                            navigationModel.pushContent(StartView.id) {
                                LoginView()
                            }
                        }) {
                            Text("Se connecter")
                        }
                        Link(destination: URL(string: "https://www.google.com")!, label: {
                            Text("Politique de confidentialité")
                                .font(.system(size: 15))
                                .underline()
                        })
                        .buttonStyle(DefaultButtonStyle())
                        .padding(.top, 100)
                        Spacer()
                    }
                    .buttonStyle(MyButtonStyle())
                    .foregroundColor(.white)
                }
        }
    }
}

//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.accentColor
//                .ignoresSafeArea()
//            StartView()
//        }
//    }
//}

struct BackButton: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var viewId = ""
    var icon = "chevron.backward"
    var systemIcon = true
    var iconColor = Color.white
    
    var body: some View {
        Button(action: {
            if viewId.isEmpty {
                navigationModel.hideTopViewWithReverseAnimation()
            } else {
                navigationModel.popContent(viewId)
            }
        }) {
            if systemIcon {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
            } else {
                Image(icon)
                    .foregroundColor(iconColor)
            }
        }
        .frame(height: 44)
    }
}

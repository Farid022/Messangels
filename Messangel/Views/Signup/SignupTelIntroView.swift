//
//  SignupView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI
import NavigationStack

struct SignupTelIntroView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    static let id = String(describing: Self.self)
    @State private var offset: CGFloat = 1000.0
    @State private var valid = true
    
    var body: some View {
        NavigationStackView("SignupTelIntroView") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton()
                    Spacer()
                    Text("""
                        Presque terminé  !
                        Nous allons vous demander
                        de confirmer votre identité avec numéro de téléphone.
                        """)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .frame(maxHeight: .infinity)
                        .offset(x:offset)
                        .onAppear{
                            DispatchQueue.main.async {
                                withAnimation {
                                    offset = 0.0
                                }
                            }
                        }
                    Image("backgroundLogo")
                        .resizable()
                        .scaledToFill()
                        .offset(x: 120)
                    Spacer().frame(height: 50)
                    HStack {
                        Link(destination: URL(string: "https://www.google.com")!, label: {
                            Text("En savoir plus sur notre engagement ")
                                .underline()
                                .font(.system(size: 13))
                        })
                        .buttonStyle(DefaultButtonStyle())
                        Spacer()
                        NextButton(source: "SignupTelIntroView", destination: AnyView(SignupTelView()), active: $valid)
                    }
                    Spacer()
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

struct SignupTelIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SignupTelIntroView()
    }
}

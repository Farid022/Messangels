//
//  SignupView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI
import NavigationStack

struct SignupIntroView: View {
    @State private var offset: CGFloat = 1000.0
    @State private var valid = true
    static let id = String(describing: Self.self)
    @EnvironmentObject var navigationModel: NavigationModel

    
    var body: some View {
        NavigationStackView(SignupIntroView.id) {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton()
                    Spacer()
                    Text("""
                        Bienvenue !
                        En vous inscrivant, vos
                        données personnelles
                        restent en sécurité.
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
                            Text("""
                                En savoir plus sur
                                nos engagements
                                """)
                                .underline()
                                .font(.system(size: 13))
                        })
                        Spacer()
                        NextButton(source: SignupIntroView.id, destination: AnyView(SignupNameView()), active: $valid)
                    }
                    Spacer()
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

//struct SignupIntroView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupIntroView()
//    }
//}

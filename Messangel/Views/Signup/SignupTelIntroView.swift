//
//  SignupView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI

struct SignupTelIntroView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var offset: CGFloat = 1000.0
    @State private var valid = true
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.accentColor
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer().frame(height: 50)
                Text("""
                    Presque terminé  !
                    Nous allons vous demander
                    de confirmer votre identité avec numéro de téléphone.
                    """)
                    .font(.title2)
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
                        Text("En savoir plus sur notre engagement ").underline()
                    })
                    .buttonStyle(DefaultButtonStyle())
                    Spacer()
                    NextButton(destination: AnyView(SignupTelView()), active: $valid)
                }
                Spacer()
            }.padding()
        }
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward").foregroundColor(.white)
        })
    }
}

struct SignupTelIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SignupTelIntroView()
    }
}

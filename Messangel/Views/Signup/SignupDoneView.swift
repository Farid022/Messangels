//
//  SignupDoneView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupDoneView: View {
    @EnvironmentObject var auth: AuthState
    @State private var offset: CGFloat = 200
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer().frame(height: 50)
                Image("logo")
                Spacer().frame(height: 50)
                Rectangle()
                    .frame(width: 60, height: 60)
                    .cornerRadius(25)
                    .overlay(
                        Image("done-check")
                    )
                    .scaleEffect(offset == 200 ? 0.5 : 1.0)
                Text("Votre profil a été créé !")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(
                """
                Vous pouvez démarrer. Consultez votre adresse mail pour valider votre compte dès que possible.
                """
                )
                Spacer()
                Button("Démarrer", action: {
                    withAnimation {
                        self.auth.user = true
                    }
                })
                    .buttonStyle(MyButtonStyle())
                    .accentColor(.black)
                .offset(y: offset)
                .animate {
                    offset = 0
                }
                Spacer().frame(height: 50)
            }.padding()
        }
        .foregroundColor(.white)
    }
}

struct SignupDoneView_Previews: PreviewProvider {
    static var previews: some View {
        SignupDoneView()
    }
}

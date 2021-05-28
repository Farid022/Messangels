//
//  SignupDoneView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct GuardianFormDoneView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var scale = false
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Rectangle()
                    .frame(width: 60, height: 60)
                    .cornerRadius(25)
                    .overlay(
                        Image("done-check")
                    )
                    .scaleEffect(scale ? 1.0 : 0.5)
                    .animate {
                        scale.toggle()
                    }
                Text("Demande envoyée")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(
                """
                Marianne recevra votre demande sur :
                marianne.milon@gmail.com.
                """
                )
                .multilineTextAlignment(.center)
                Spacer().frame(height: 10)
                Button("Revenir à l’accueil", action: {
                    withAnimation {
                        self.mode.wrappedValue.dismiss()
                    }
                })
                    .buttonStyle(MyButtonStyle())
                    .accentColor(.black)
                Spacer()
            }.padding()
        }
        .foregroundColor(.white)
    }
}

struct GuardianFormDoneView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormDoneView()
    }
}

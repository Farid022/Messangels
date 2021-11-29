//
//  FuneralDoneView.swift
//  Messangel
//
//  Created by Saad on 10/20/21.
//

import SwiftUI
import NavigationStack

struct FuneralDoneView: View {
    @EnvironmentObject var navigationModel: NavigationModel
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
                Text("Enregistré dans votre Messangel")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text("Vous pourrez modifier ou ajouter des informations en revenant sur cette séquence plus tard.")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                Spacer().frame(height: 10)
                Button("Voir mon Messangel", action: {
                    withAnimation {
                        navigationModel.popContent(TabBarView.id)
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


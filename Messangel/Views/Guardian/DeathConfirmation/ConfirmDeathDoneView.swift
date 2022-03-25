//
//  DDDoneView.swift
//  Messangel
//
//  Created by Saad on 2/26/22.
//

import SwiftUI
import NavigationStack

struct ConfirmDeathDoneView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var scale = false
    @ObservedObject var vm: GuardianViewModel
    
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
                Text("Décès déclaré")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text(
                """
                Vous pourrez accéder au Messangel de \(vm.protectedUser.last_name) \(vm.protectedUser.first_name) sous 12h. Nous vous tiendrons informé(e) par mail et SMS.
                """
                )
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                Spacer().frame(height: 10)
                Button("Revenir à l’accueil", action: {
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

//
//  HomeView.swift
//  Messangel
//
//  Created by Saad on 5/17/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Mes Anges-gardiens")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
            }
            .padding(.top)
            Rectangle()
                .fill(Color.white)
                .frame(width: 56, height: 56)
                .cornerRadius(25)
                .shadow(color: .gray.opacity(0.2), radius: 5)
                .overlay(NavigationLink(
                    destination: GuardianFormIntroView()) {
                    Image("add-user")
                        .opacity(0.5)
                })
            Text("Abonnez-vous pour ajouter vos Anges-gardiens.")
                .padding([.bottom, .horizontal])
            SubscribeButton()
            Spacer()
        }
        .navigationBarItems(trailing: HStack() {
            Button(action: {}, label: {
                Image("help")
                    .padding(.horizontal, -30)
            })
            NavigationLink(destination: MenuView()) {
                Image("menu")
                    .padding()
            }
            .padding(.bottom, 10)
        })
    }
}

struct SubscribeButton: View {
    var body: some View {
        NavigationLink(destination: SubscriptionView()) {
            Text("Je m’abonne (2€/mois)")
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 56)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(25)
        .padding(.horizontal, 70)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .background(Color.accentColor)
    }
}

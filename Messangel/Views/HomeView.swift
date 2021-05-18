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
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Group {
                        Text("Bonjour,")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        Text("Sophie")
                            .padding(.bottom, 30)
                    }
                    .foregroundColor(.white)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Voir mon Messangel")
                    })
                    .buttonStyle(MyButtonStyle(padding: 0, maxWidth: false))
                    Spacer().frame(height: 130)
                    Text("Mes Anges-gardiens")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .overlay(
                Image("backgroundLogo")
                    .resizable()
                    .frame(width: 280.05, height: 251.9)
                    .offset(x: 180),
                alignment: .top
            )
            .padding()
            
            //MARK:- Bottom View
            Rectangle()
                .fill(Color.white)
                .frame(width: 56, height: 56)
                .cornerRadius(25)
                .shadow(color: .gray.opacity(0.2), radius: 5)
                .overlay(Image("add-user").opacity(0.5))
            Text("Abonnez-vous pour ajouter vos Anges-gardiens.")
                .padding(.bottom)
            NavigationLink(destination: SubscriptionView()) {
                Text("Je m’abonne (2€/mois)")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(20)
            .padding(.horizontal, 70)
            Spacer()
        }
        .navigationBarItems(trailing: HStack() {
            Button(action: {}, label: {
                Image("help")
                    .padding(.horizontal, -30)
            })
            Button(action: {}, label: {
                Image("menu")
                    .padding()
            })
            .padding(.bottom, 10)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .background(Color.accentColor)
    }
}

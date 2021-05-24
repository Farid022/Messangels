//
//  HomeView.swift
//  Messangel
//
//  Created by Saad on 5/17/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { g in
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
                        Spacer()
                            .frame(height: 50)
                    }
                    Spacer()
                }
                .frame(height: UIDevice.current.hasNotch ? g.size.height/2.7 : g.size.height/2.8)
                .overlay(
                    Image("backgroundLogo")
                        .resizable()
                        .frame(width: 280.05, height: 251.9)
                        .offset(x: 180),
                    alignment: .top
                )
                .padding()
                
                //MARK:- Bottom View
                HStack {
                    Text("Mes Anges-gardiens")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                }
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
                NavigationLink(destination: MenuView()) {
                    Image("menu")
                        .padding()
                }
                .padding(.bottom, 10)
        })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .background(Color.accentColor)
    }
}

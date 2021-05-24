//
//  MenuView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let hasNotch = UIDevice.current.hasNotch
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Color.accentColor
                .frame(height: hasNotch ? 150 : 100)
                .edgesIgnoringSafeArea(.top)
            List(menuList) {menuItem in
                ZStack {
                    Button("") {}
                    NavigationLink(destination: menuItem.destination) {
                        HStack {
                            Image(menuItem.ic)
                            Text(menuItem.id)
                        }
                        .padding(.vertical, 20)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Text("Menu")
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .foregroundColor(.white),
                            trailing:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                }
        )
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
    }
}

private struct MainMenu: Identifiable {
    var id: String
    var ic: String
    var destination: AnyView
}

private let menuList: [MainMenu] = [
    MainMenu(id: "Profil", ic: "ic_profile", destination: AnyView(ProfileView())),
    MainMenu(id: "Accès et sécurité", ic: "ic_lock", destination: AnyView(ProfileView())),
    MainMenu(id: "Abonnement", ic: "ic_card", destination: AnyView(ProfileView())),
    MainMenu(id: "Liste de contacts", ic: "ic_contacts", destination: AnyView(ProfileView())),
    MainMenu(id: "Parrainer un proche", ic: "ic_sponsor", destination: AnyView(ProfileView())),
    MainMenu(id: "Notifications et alertes SMS", ic: "ic_bell", destination: AnyView(ProfileView())),
    MainMenu(id: "Propositions d’améliorations", ic: "ic_bulb", destination: AnyView(ProfileView())),
    MainMenu(id: "Support/F.A.Q", ic: "ic_wheel", destination: AnyView(ProfileView())),
    MainMenu(id: "À propos de Messangel", ic: "ic_info", destination: AnyView(ProfileView())),
    MainMenu(id: "Se déconnecter", ic: "ic_logout", destination: AnyView(ProfileView()))
]

//
//  MenuView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import NavigationStack

struct MenuView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        NavigationStackView("MenuView") {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Color.accentColor
                    .frame(height: 50)
                    .edgesIgnoringSafeArea(.top)
                VStack(spacing: 0.0) {
                    Color.accentColor
                        .frame(height: 150)
                        .overlay(TopBar(), alignment: .bottom)
                    List(menuList) {menuItem in
                        ZStack {
//                            Button("") {}
                            Button(action: {
                                navigationModel.pushContent("MenuView") {
                                    menuItem.destination
                                }
                            }) {
                                HStack {
                                    Image(menuItem.ic)
                                    Text(menuItem.id)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                                .padding(.vertical, 20)
                            }
                        }
                    }
                    .padding()
                    Spacer().frame(height: 80)
                }
            }
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
    MainMenu(id: "Accès et sécurité", ic: "ic_lock", destination: AnyView(AccessSecurityView())),
    MainMenu(id: "Abonnement", ic: "ic_card", destination: AnyView(EditSubscriptionView())),
    MainMenu(id: "Liste de contacts", ic: "ic_contacts", destination: AnyView(ContactsListView())),
    MainMenu(id: "Parrainer un proche", ic: "ic_sponsor", destination: AnyView(SponsorView())),
    MainMenu(id: "Notifications et alertes SMS", ic: "ic_bell", destination: AnyView(NotificationsView())),
    MainMenu(id: "Propositions d’améliorations", ic: "ic_bulb", destination: AnyView(SuggestionsView())),
    MainMenu(id: "Support/F.A.Q", ic: "ic_wheel", destination: AnyView(FAQView())),
    MainMenu(id: "À propos de Messangel", ic: "ic_info", destination: AnyView(AboutView())),
    MainMenu(id: "Se déconnecter", ic: "ic_logout", destination: AnyView(ProfileView()))
]

struct TopBar: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        HStack {
            Text("Menu")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                navigationModel.hideTopViewWithReverseAnimation()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

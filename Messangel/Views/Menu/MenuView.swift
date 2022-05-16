//
//  MenuView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import NavigationStack

struct MenuView: View {
    @EnvironmentObject private var subVM: SubscriptionViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var auth: Auth
    
    init() { UITableView.appearance().backgroundColor = UIColor.white }

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
                    List(menuList()) { menuItem in
//                        ZStack {
//                            Button("") {}
                            Button(action: {
                                if menuItem.ic == "ic_profile" {
                                    navigationModel.pushContent("MenuView") {
                                        ProfileView()
                                    }
                                }
                                else if menuItem.ic == "ic_logout" {
                                    auth.removeUser()
                                    navigationModel.pushContent(TabBarView.id) {
                                        StartView()
                                    }
                                } else {
                                    navigationModel.pushContent("MenuView") {
                                        menuItem.destination
                                    }
                                }
                            }) {
                                HStack {
                                    Image(menuItem.ic)
                                    Text(menuItem.id)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                                .padding(.vertical, 20)
                            }
//                        }
                    }
                    Spacer().frame(height: 80)
                }
            }
        }
    }
    
    private func menuList() -> [MainMenu] {
        return [
            MainMenu(id: "Profil", ic: "ic_profile", destination: AnyView(EmptyView())),
            MainMenu(id: "Accès et sécurité", ic: "ic_lock", destination: AnyView(AccessSecurityView())),
            MainMenu(id: "Abonnement", ic: "ic_card", destination: AnyView(EditSubscriptionView())),
            MainMenu(id: "Liste de contacts", ic: "ic_contacts", destination: AnyView(ContactsListView())),
            MainMenu(id: "Liste de organismes", ic: "ic_company", destination: AnyView(OrganizationsListView())),
            MainMenu(id: "Parrainer un proche", ic: "ic_sponsor", destination: AnyView(SponsorView())),
            MainMenu(id: "Notifications et alertes SMS", ic: "ic_bell", destination: AnyView(NotificationsView())),
            MainMenu(id: "Propositions d’améliorations", ic: "ic_bulb", destination: AnyView(SuggestionsView())),
            MainMenu(id: "Support/F.A.Q", ic: "ic_wheel", destination: AnyView(FAQView())),
            MainMenu(id: "À propos de Messangel", ic: "ic_info", destination: AnyView(AboutView())),
            MainMenu(id: "Se déconnecter", ic: "ic_logout", destination: AnyView(StartView()))
        ]
    }
}

private struct MainMenu: Identifiable {
    var id: String
    var ic: String
    var destination: AnyView
}

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



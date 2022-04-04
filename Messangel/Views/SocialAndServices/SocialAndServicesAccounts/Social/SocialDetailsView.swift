//
//  ServiceDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct SocialDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    @ObservedObject var vm: OnlineServiceViewModel
    var account: OnlineServiceAccountDetail
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce compte-clé") {
                vm.del(id: account.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: ServicesListView.self))
                        vm.getAccounts { _ in }
                    }
                }
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        Color.accentColor
                            .frame(height:90)
                            .padding(.horizontal, -20)
                            .overlay(
                                HStack {
                                    BackButton()
                                    Spacer()
                                }, alignment: .top)
                        
                        VStack {
                            Color.accentColor
                                .frame(height: 35)
                                .overlay(Text("Comptes-clés")
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding([.leading, .bottom])
                                         ,
                                         alignment: .leading)
                            Color.white
                                .frame(height: 15)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, -16)
                        .padding(.top, -16)
                        .overlay(HStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .cornerRadius(25)
                                .normalShadow()
                                .overlay(Image("info"))
                        })
                        HStack {
                            BackButton(iconColor: .gray)
                            Text(account.accountFields.onlineService.name)
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        SocialDetailsSubView(email: account.accountFields.mailAccount.email, phoneName: account.accountFields.smartphone.name, url: account.accountFields.onlineService.url)
                        DetailsNoteView(note: account.accountFields.manageAccountNote)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.account = OnlineServiceAccount(id: account.id, accountId: account.id, lastPostNote: account.lastPostNote, lastPostImage: account.lastPostImage, lastPostImageNote: account.lastPostImageNote, leaveMsgTime: account.leaveMsgTime, memorialAccount: account.memorialAccount, memorialAccountNote: account.memorialAccountNote)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                SocialNoteView(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct SocialDetailsSubView: View {
    var email: String
    var phoneName: String
    var url: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_key_color_native")
                Text(email)
                Spacer()
            }
            HStack {
                Image("ic_phone")
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
                Text(phoneName)
                Spacer()
            }
            HStack {
                Text("Gestion")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text(url)
                Spacer()
            }
//            HStack {
//                Image("ic_item_info")
//                Text("*Clôturer immédiatement/*Mettre un message (Note)")
//                Spacer()
//            }
//            HStack {
//                Image("ic_item_info")
//                Text("Ajouter une photo")
//                Spacer()
//            }
//            HStack {
//                Image("ic_item_info")
//                Text("Clôturer le compte après 1 mois")
//                Spacer()
//            }
            HStack {
                Image("ic_item_info")
                Text(agreeMemorialAccount)
                Spacer()
            }
        }
    }
}

private var agreeMemorialAccount = "J’accepte qu’un compte commémoratif soit créé sur ce réseau social"
private var disgardMemorialAccount = "Je refuse qu’un compte commémoratif soit créé sur ce réseau social"

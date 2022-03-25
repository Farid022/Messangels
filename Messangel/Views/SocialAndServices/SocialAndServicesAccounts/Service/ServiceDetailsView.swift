//
//  ServiceDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct ServiceDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    @ObservedObject var vm: OnlineServiceViewModel
    var account: OnlineServiceAccountDetail
    private let confirmMessage = "Les informations liées seront supprimées définitivement"
    
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
                            Text("\(account.accountFields.onlineService.name)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        ServiceDetailsSubView()
                        DetailsNoteView(note: account.accountFields.manageAccountNote)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
//                            vm.account = OnlineServiceAccount(id: account.id, accountId: account.id, lastPostNote: account.lastPostNote, lastPostImage: account.lastPostImage, leaveMsgTime: account.leaveMsgTime, memorialAccount: account.memorialAccount)
//                            vm.updateRecord = true
//                            navigationModel.pushContent(String(describing: Self.self)) {
//
//                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ServiceDetailsSubView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_key_color_native")
                Text("sophie.carnero@gmail.com")
                Spacer()
            }
            HStack {
                Image("ic_phone")
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
                Text("iPhone de Sophie")
                Spacer()
            }
            HStack {
                Text("Gestion")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text("www.ne.com")
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text("Gérer le compte (Note)")
                Spacer()
            }
        }
    }
}

//
//  KeyAccDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct KeyAccDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    @ObservedObject var vm: KeyAccViewModel
    var keyEmail: PrimaryEmailAcc
    var confirmMessage = """
ATTENTION
En supprimant ce compte mail, vous supprimerez l’accès à 20 comptes (réseaux sociaux ou services en ligne)
"""
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce compte-clé") {
                vm.delKeyMail(id: keyEmail.id ?? 0) { success in
                    if success {
                        navigationModel.popContent(String(describing: KeyMailsAndPhonesView.self))
                        vm.getKeyAccounts { _ in }
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
                            Text("\(keyEmail.email)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        KeyAccDetailsSubView()
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.keyEmailAcc = PrimaryEmailAcc(id: keyEmail.id, email: keyEmail.email, password: keyEmail.password, note: keyEmail.note, deleteAccount: keyEmail.deleteAccount)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                KeyAccRegEmailView(keyAccCase: .manage, vm: vm)
                            }
                        }
                       
                    }
                    .padding()
                }
            }
        }
    }
}

struct KeyAccDetailsSubView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
//            HStack {
//                Image("ic_key_color_native")
//                Text("Associé à 5 comptes")
//                Spacer()
//            }
            HStack {
                Image("ic_lock_color_native")
                Text("••••••••")
                Spacer()
            }
            HStack {
                Text("Gestion")
                    .font(.system(size: 17), weight: .bold)
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

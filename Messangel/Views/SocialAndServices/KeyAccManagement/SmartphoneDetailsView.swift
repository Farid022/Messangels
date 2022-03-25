//
//  SmartphoneDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct SmartphoneDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    @ObservedObject var vm: KeyAccViewModel
    var keyPhone: PrimaryPhone
    var confirmMessage = """
ATTENTION
En supprimant ce smartphone, vous supprimerez l’accès à 12 comptes (réseaux sociaux ou services en ligne)
"""
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce smartphone") {
                vm.delKeyPhone(id: keyPhone.id ?? 0) { success in
                    if success {
                        navigationModel.popContent(String(describing: KeyMailsAndPhonesView.self))
                        vm.getKeyPhones()
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
                            Text("\(keyPhone.name)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        SmartphoneDetailsSubView(phoneNum: keyPhone.phoneNum)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.keySmartPhone = PrimaryPhone(id: keyPhone.id, name: keyPhone.name, phoneNum: keyPhone.phoneNum, pincode: keyPhone.phoneNum, deviceUnlockCode: keyPhone.deviceUnlockCode)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                KeyAccRegPhoneNameView(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct SmartphoneDetailsSubView: View {
    var phoneNum: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
//            HStack {
//                Image("ic_key_color_native")
//                Text("Associé à 0 compte")
//                Spacer()
//            }
            HStack {
                Image("ic_lock_color_native")
                Text("•••• (PIN)")
                Spacer()
            }
            HStack {
                Image("ic_lock_color_native")
                Text("•••••• (Code de dévérouillage)")
                Spacer()
            }
            HStack {
                Text("Numéro")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text(phoneNum)
                Spacer()
            }
        }
    }
}


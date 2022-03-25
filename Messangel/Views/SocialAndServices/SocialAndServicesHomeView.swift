//
//  ServicesBottomView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct SocialAndServicesHomeView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var keyAccVM: AccStateViewModel
    @State private var showKeyAccDesc = false
    @ObservedObject var vmOnlineService: OnlineServiceViewModel
    @Binding var loading: Bool
    @Binding var showPopUp: Bool
    
    var body: some View {
        NavigationStackView("SocialAndServicesHomeView") {
            VStack {
                if !loading {
                    VStack {
                        VStack {
                            if vmOnlineService.accounts.count == 0 {
                                Spacer().frame(height: 150)
                                Image(!keyAccVM.keyAccRegistered ? "ic_key" : "ic_plus")
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .padding(.bottom)
                                Text(!keyAccVM.keyAccRegistered ? """
                                         Pour commencer,
                                         enregistrez un compte-clé
                                     """
                                     :
                                        "Ajoutez votre premier réseau social ou service en ligne")
                                    .font(.system(size: 17), weight: .bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 25)
                            } else {
                                ForEach(vmOnlineService.accounts, id: \.self) { account in
                                    ServiceCapsule(name: account.accountFields.onlineService.name, isList: true)
                                        .onTapGesture {
                                            if account.accountFields.onlineService.type == "listing" {
                                                navigationModel.pushContent(TabBarView.id) {
                                                    ServiceDetailsView(vm: vmOnlineService, account: account)
                                                }
                                            } else {
                                                navigationModel.pushContent(TabBarView.id) {
                                                    SocialDetailsView(vm: vmOnlineService, account: account)
                                                }
                                            }
                                        }
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        if !keyAccVM.keyAccRegistered {
                            Button {
                                withAnimation {
                                    showKeyAccDesc.toggle()
                                }
                            } label: {
                                Text("Qu’est-ce qu’un compte clé ?")
                                    .font(.system(size: 13))
                                    .underline()
                                    .foregroundColor(.secondary)
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .overlay {
                                        VStack {
                                            Text(keyAccDesc1)
                                                .font(.system(size: 13), weight: .semibold)
                                                .padding(.bottom, 20)
                                            Text(keyAccDesc2)
                                                .font(.system(size: 13))
                                                .padding(.bottom, 20)
                                                .padding(.trailing)
                                            HStack {
                                                Text("Fermer")
                                                    .font(.system(size: 11))
                                                    .underline()
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            showKeyAccDesc.toggle()
                                        }
                                    }
                                    .opacity(showKeyAccDesc ? 1 : 0)
                            }
                            .padding()
                        } //!keyAccRegVM.keyAccRegistered
                    }
                } else {
                    Loader()
                }
            }
        }
    }
}

struct NewAccPopupView: View {
    @Binding var showPopUp: Bool
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack(spacing: -20.0) {
                Spacer()
                Button {
                    showPopUp.toggle()
                    navigationModel.pushContent(TabBarView.id) {
                        KeyAccRegSecView(keyAccCase: .manage)
                    }
                } label: {
                    Image("btn_key")
                }
                Button {
                    navigationModel.pushContent(TabBarView.id) {
                        ServicesListView()
                    }
                } label: {
                    Image("btn_social")
                }
                Button {
                    showPopUp.toggle()
                } label: {
                    Image("btn_add_toggle")
                }
                Spacer().frame(height: 90)
            }
            .padding(.trailing)
        }
        .zIndex(1)
    }
}



private var keyAccDesc1 = "Vos comptes-clés sont les comptes email (Gmail, Hotmail…) avec lesquels vous gérez vos réseaux sociaux et vos services en ligne."

private var keyAccDesc2 = "Enregistrez un compte-clé pour permettre à vos Anges-Gardiens d’y accéder et de gérer tous les comptes associés"

struct NewAccountServiceButtonView: View {
    @Binding var showPopUp: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        showPopUp.toggle()
                    }
                } label: {
                    Image("btn_add")
                        .frame(width: 56, height: 56)
                }
            }
            Spacer().frame(height: 90)
        }
        .padding(.horizontal)
    }
}

struct NewMainAccButtonView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    navigationModel.pushContent(TabBarView.id) {
                        KeyAccRegSecView(keyAccCase: .register)
                    }
                } label: {
                    Image("btn_key")
                        .frame(width: 56, height: 56)
                }
            }
            Spacer().frame(height: 90)
        }
        .padding(.horizontal)
    }
}

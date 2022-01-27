//
//  KeyAccRegPhoneCodeView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct KeyAccRegPhoneCodeView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var keyAccVM: AccStateViewModel
    @ObservedObject var vm: KeyAccViewModel
    
    var body: some View {
        NavigationStackView("KeyAccRegPhoneCodeView") {
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
                        Text("Quitter")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
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
                        Text("\(vm.keySmartPhone.name) - Saisissez le code de déverrouillage de l’appareil")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                    .padding(.bottom)
                    TextField("Code de dévérouillage", text: $vm.keySmartPhone.deviceUnlockCode)
                        .textFieldStyle(MyTextFieldStyle())
                        .normalShadow()
                    Spacer()
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(!vm.keySmartPhone.deviceUnlockCode.isEmpty ? Color.accentColor : Color.gray.opacity(0.2))
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .overlay(
                                Button(action: {
                                    if vm.keySmartPhone.deviceUnlockCode.isEmpty {
                                        return
                                    }
                                    if keyAccVM.keyAccCase == .register {
                                        vm.addPrimaryPhone { success in
                                            if success {
                                                navigationModel.popContent(TabBarView.id)
                                                keyAccVM.showSuccessScreen.toggle()
                                                keyAccVM.keyAccRegistered.toggle()
                                            }
                                        }
                                    } else {
                                        navigationModel.popContent("KeyMailsAndPhonesView")
                                    }
                                }) {
                                    Image(systemName: "chevron.right").foregroundColor(!vm.keySmartPhone.deviceUnlockCode.isEmpty ? Color.white : Color.gray)
                                }
                            )
                    } // HStack
                    
                }
                .padding()
            }
        }
    }
}

struct KeyAccRegSuccessView: View {
    @EnvironmentObject var keyAccRegVM: AccStateViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        keyAccRegVM.showSuccessScreen.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(30)
                            .padding(.top, 50)
                    }
                    Spacer()
                }
                Spacer()
                Image("ic_ok")
                Text("Vous pouvez désormais ajouter vos réseaux sociaux et services en ligne")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Button {
                    keyAccRegVM.showSuccessScreen.toggle()
                } label: {
                    Image("btn_ok")
                }
                Spacer()
            }
            
        }
        .zIndex(1)
    }
}


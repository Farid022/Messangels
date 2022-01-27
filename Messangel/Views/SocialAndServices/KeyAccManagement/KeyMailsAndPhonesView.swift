//
//  KeyMailsAndPhonesView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct KeyMailsAndPhonesView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var keyAccVM: KeyAccViewModel
    @StateObject private var vm = KeyAccViewModel()
    static let id = String(describing: Self.self)
    @State private var loading = true
    
    var body: some View {
        NavigationStackView(KeyMailsAndPhonesView.id) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .edgesIgnoringSafeArea(.top)
                    .frame(height:70)
                VStack(spacing: 20) {
                    Color.accentColor
                        .frame(height:90)
                        .padding(.horizontal, -20)
                        .overlay(
                            HStack {
                                BackButton(viewId: TabBarView.id, icon:"ic_exit", systemIcon: false)
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
                        Text("Comptes mails")
                            .font(.system(size: 17), weight: .bold)
                        Spacer()
                        Button {
                            navigationModel.pushContent(KeyMailsAndPhonesView.id) {
                                KeyAccRegEmailView(keyAccCase: .addEmail)
                            }
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.accentColor)
                                .frame(width: 13.5, height: 13.5)
                        }
                    }
                    .padding(.top)
                    if !loading {
                        ForEach(vm.keyAccounts, id: \.self) { account in
                            KeyAccountCapsule(email: account.email, selected: .constant(false))
                                .onTapGesture {
                                    navigationModel.pushContent(KeyMailsAndPhonesView.id) {
                                        KeyAccDetailsView(email: account.email, note: account.note)
                                    }
                                }
                        }
                    } else {
                        Loader()
                    }
                    HStack {
                        Text("Smartphones")
                            .font(.system(size: 17), weight: .bold)
                        Spacer()
                        Button {
                            navigationModel.pushContent(KeyMailsAndPhonesView.id) {
                                KeyAccRegPhoneNameView()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.accentColor)
                                .frame(width: 13.5, height: 13.5)
                        }
                    }
                    .padding(.top)
                    if !loading {
                        ForEach(vm.smartphones, id: \.self) { phone in
                            PhoneCapsule(name: phone.name, selected: .constant(false))
                                .onTapGesture {
                                    navigationModel.pushContent(KeyMailsAndPhonesView.id) {
                                        SmartphoneDetailsView(phoneName: phone.name)
                                    }
                                }
                        }
                    } else {
                        Loader()
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onDidAppear {
            vm.getKeyAccounts { success in
                self.loading.toggle()
            }
            vm.getKeyPhones()
        }
    }
}

struct KeyAccountCapsule: View {
    var email: String
    @Binding var selected: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(selected ? .accentColor : .white)
            .frame(height: 56)
            .normalShadow()
            .overlay(HStack {
                Image("ic_key")
                Text(email)
                    .foregroundColor(selected ? .white : .black)
            })
    }
}

struct PhoneCapsule: View {
    var name: String
    @Binding var selected: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(selected ? .accentColor : .white)
            .frame(height: 56)
            .normalShadow()
            .overlay(HStack {
                Image("ic_phone")
                Text(name)
                    .foregroundColor(selected ? .white : .black)
            })
    }
}

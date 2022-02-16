//
//  AdminDocs.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AdminDocsIntro: View {
    @StateObject private var vm = AdminDocViewModel()
    @State private var gotList = false
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStackView("AdminDocsIntro") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton(icon:"xmark")
                    Spacer()
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .normalShadow()
                            .overlay(Image("info"))
                        Spacer()
                    }
                    .padding(.bottom)
                    Text("Pièces administratives")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Liste des pièces administratives utiles : Carte d’identité, passeport, carte vitale…")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent("AdminDocsIntro") {
                                if vm.adminDocs.isEmpty {
                                    AdminDocsNew(vm: vm)
                                } else {
                                    AdminDocsList(vm: vm, refresh: false)
                                }
                            }
                        }, active: .constant(gotList))
                            .animation(.default, value: gotList)
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.getAll { _ in
                gotList.toggle()
            }
        }
    }
}

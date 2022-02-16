//
//  AdminDocs.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractsIntro: View {
    @StateObject private var vm = ContractViewModel()
    @State private var gotList = false
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStackView("ManagedContractsIntro") {
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
                    Text("Contrats à gérer")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Liste des organismes qui gèrent les contrats liés à votre quotidien (Logement, banque, assurance, mutuelle…)")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent("ManagedContractsIntro") {
                                if vm.contracts.isEmpty {
                                    ManagedContractNew(vm: vm)
                                } else {
                                    ManagedContractsList(vm: vm, refresh: false)
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

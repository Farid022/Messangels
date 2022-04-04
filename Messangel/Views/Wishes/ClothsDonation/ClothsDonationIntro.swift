//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationIntro: View {
    @State private var gotList = false
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = ClothDonationViewModel()
    
    var body: some View {
        NavigationStackView("ClothsDonationIntro") {
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
                    Text("Vêtements et accessoires")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez les vêtements que vous souhaitez transmettre à vos proches ou donner à des associations. ")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent("ClothsDonationIntro") {
                                if vm.donations.isEmpty {
                                    ClothsDonationNew()
                                } else {
                                    ClothsDonationsList(vm: vm, refresh: false)
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

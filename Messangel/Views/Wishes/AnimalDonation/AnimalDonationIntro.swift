//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationIntro: View {
    @StateObject private var vm = AnimalDonatiopnViewModel()
    @State private var gotList = false
    @EnvironmentObject private var navigationModel: NavigationModel
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
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
                    Text("ANIMAUX")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez vos animaux puis désignez les personnes ou organismes auxquels vous souhaitez les confier. Vous pourrez également apporter des précisions sur chacun de vos animaux : habitudes alimentaires, fréquence de sortie…")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent(String(describing: Self.self)) {
                                if vm.donations.isEmpty {
                                    AnimalDonationNew(vm: vm)
                                } else {
                                    AnimalDonationsList(vm: vm, refresh: false)
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

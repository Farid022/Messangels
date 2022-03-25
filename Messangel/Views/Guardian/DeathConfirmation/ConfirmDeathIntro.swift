//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ConfirmDeathIntro: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: GuardianViewModel
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
                    Text("Déclarer un décès")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Avertissement : ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            let deathConfirm = ["death_dec" : 1, "status": 1, "guardian" : getUserId()]
                            APIService.shared.post(model: deathConfirm, response: vm.apiResponse, endpoint: "users/\(getUserId())/death_accept") { result in
                                DispatchQueue.main.async {
                                    vm.guardiansUpdated = true
                                    navigationModel.pushContent(String(describing: Self.self)) {
                                        ConfirmDeathDoneView(vm: vm)
                                    }
                                }
                            }
                        }, active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

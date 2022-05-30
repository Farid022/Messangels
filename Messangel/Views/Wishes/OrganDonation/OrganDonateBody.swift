//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateBody: View {
    @State private var loading = false
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    private let  title = "Pour donner votre corps à la science, vous devez effectuer des démarches auprès d’organismes spécialisés."

    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 3.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.create() { success in
                        if success {
                            WishesViewModel.setProgress(tab: 4) { completed in
                                loading.toggle()
                                wishChoiceSuccessAction(title, navModel: navModel)
                            }
                        }
                    }
                } else {
                    vm.update(id: vm.donations[0].id) { success in
                        loading.toggle()
                        if success {
                            wishChoiceSuccessAction(title, navModel: navModel)
                        }
                    }
                }
            }, menuTitle: "Don d’organes ou du corps à la#science", title: title, valid: .constant(true)) {
                viewMessangelGuide()
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
            
        }
    }
}

func viewMessangelGuide() -> some View {
    return HStack {
        Button(action: {
            
        }, label: {
            Text("Voir notre guide Messangel")
        })
            .buttonStyle(MyButtonStyle(padding: 20, maxWidth: false, foregroundColor: .white, backgroundColor: .accentColor))
        Spacer()
    }
}

func wishChoiceSuccessAction(_ title: String, navModel: NavigationModel) {
    navModel.pushContent(title) {
        FuneralDoneView()
    }
}

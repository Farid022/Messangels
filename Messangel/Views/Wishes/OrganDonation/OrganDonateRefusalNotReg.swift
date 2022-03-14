//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateRefusalNotReg: View {
//    @State private var showNote = false
//    @State private var note = ""
    @State private var loading = false
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Pour refuser le don d’organes, vous devez être inscrit sur le registre national des refus."
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 4.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.create() { success in
                        if success {
                            WishesViewModel.setProgress(tab: 4) { completed in
                                loading.toggle()
                                if completed {
                                    wishChoiceSuccessAction(title, navModel: navModel)
                                }
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

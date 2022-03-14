//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateChoice: View {
    @EnvironmentObject private var navModel: NavigationModel
    private let donationChoices = [OrganDonChoice.organs, OrganDonChoice.deny, OrganDonChoice.body]
    private let title = "Pour quel choix avez-vous opté ?"
//    @State private var showNote = false
    @State private var loading = false
//    @State private var note = ""
    @ObservedObject var vm: OrganDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 1.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                if vm.donation.donation == OrganDonChoice.organs.rawValue {
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
                } else if vm.donation.donation == OrganDonChoice.deny.rawValue {
                    navModel.pushContent(title) {
                        OrganDonateRefuse(vm: vm)
                    }
                } else {
                    navModel.pushContent(title) {
                        OrganDonateBody(vm:vm)
                    }
                }
            }, menuTitle: "Don d’organes ou du corps à la science", title: title, valid: .constant(vm.donation.donation != OrganDonChoice.none.rawValue)){
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10.0), count: 2), spacing: 10.0) {
                    ForEach(donationChoices, id: \.self) { donChoice in
                        ChoiceCard(text: donChoice == .organs ? "Donner vos organes" : donChoice == .deny ? "Ne pas donner vos organes" : "Donner votre corps à la science", selected: .constant(vm.donation.donation == donChoice.rawValue))
                            .onTapGesture {
                                vm.donation.donation = donChoice.rawValue
                            }
                    }
                }
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

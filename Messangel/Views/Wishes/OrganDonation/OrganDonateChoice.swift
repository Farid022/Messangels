//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct OrganDonateChoice: View {
    var donationChoices = [OrganDonChoice.organs, OrganDonChoice.deny, OrganDonChoice.body]
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = OrganDonationViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Pour quel choix avez-vous opté ?", valid: $valid, destination: vm.donation.donation == OrganDonChoice.organs.rawValue ? AnyView(FuneralDoneView()) : vm.donation.donation == OrganDonChoice.deny.rawValue ? AnyView(OrganDonateRefuse(vm: vm)) : AnyView(OrganDonateBody(vm:vm))) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10.0), count: 2), spacing: 10.0) {
                    ForEach(donationChoices, id: \.self) { donChoice in
                        ChoiceCard(text: donChoice == .organs ? "Donner vos organes" : donChoice == .deny ? "Ne pas donner vos organes" : "Donner votre corps à la science", selected: .constant(vm.donation.donation == donChoice.rawValue))
                            .onTapGesture {
                                vm.donation.donation = donChoice.rawValue
                            }
                    }
                }
            }
            .onChange(of: vm.donation.donation) { value in
                valid = vm.donation.donation != OrganDonChoice.none.rawValue
            }
        }
    }
}

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct OrganDonateChoice: View {
    private var donationChoices = [OrganDonChoice.organs, OrganDonChoice.deny, OrganDonChoice.body]
    @State private var valid = false
    @State private var selectedDonation = OrganDonChoice.none
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Pour quel choix avez-vous opté ?", valid: $valid, destination: selectedDonation == .organs ? AnyView(FuneralDoneView()) : selectedDonation == .deny ? AnyView(OrganDonateRefuse()) : AnyView(OrganDonateBody())) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10.0), count: 2), spacing: 10.0) {
                    ForEach(donationChoices, id: \.self) { donChoice in
                        FuneralTypeCard(text: donChoice == .organs ? "Donner vos organes" : donChoice == .deny ? "Ne pas donner vos organes" : "Donner votre corps à la science", selected: .constant(selectedDonation == donChoice))
                            .onTapGesture {
                                selectedDonation = donChoice
                            }
                    }
                }
            }
            .onChange(of: selectedDonation) { value in
                valid = selectedDonation != .none
            }
        }
    }
}

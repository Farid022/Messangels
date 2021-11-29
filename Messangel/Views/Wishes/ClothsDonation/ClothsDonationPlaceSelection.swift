//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct ClothsDonationPlaceSelection: View {
    private var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationPlace.none
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Vêtements et accessoires", title: "À qui souhaitez vous donner *cet article *ces articles?", valid: $valid, destination: selectedDonation == .organization ? AnyView(ClothsDonationOrganization()) : AnyView(ClothsDonationContact())) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        FuneralTypeCard(text: type == .contact ? "Un contact" : "Un organisme", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
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

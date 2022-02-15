//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationPlaceSelection: View {
    var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationPlace.none
    @State private var showNote = false
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
//            if showNote {
//               FuneralNote(showNote: $showNote, note: $note)
//                .zIndex(1.0)
//                .background(.black.opacity(0.8))
//                .edgesIgnoringSafeArea(.top)
//            }
            FlowBaseView(menuTitle: "ANIMAUX", title: "À qui confier *votre animal *vos animaux?", valid: $valid, destination: selectedDonation == .organization ? AnyView(AnimalDonationOrganization(vm: vm)) : AnyView(AnimalDonationContact(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .contact ? "Un contact" : "Un organisme", selected: .constant(selectedDonation == type))
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

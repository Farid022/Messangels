//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct ObjectsDonationPlaceSelection: View {
    var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationPlace.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Objets", title: "À qui souhaitez vous donner *cet objet *ce groupe d’objets?", valid: $valid, destination: selectedDonation == .organization ? AnyView(ObjectsDonationOrganization(vm: vm)) : AnyView(ObjectsDonationContact(vm: vm))) {
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

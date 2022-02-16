//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ObjectsDonationCount: View {
    private let donationTypes = [ClothsDonationType.single, ClothsDonationType.multiple]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationType.none
    @State private var showNote = false
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.objectDonation.single_object_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Objets", title: "Souhaitez-vous ajouter un ou plusieurs objets ?", valid: $valid, destination: AnyView(ObjectsDonationName(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .single ? "Un seul objet" : "Plusieurs objets", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                                vm.objectDonation.single_object = type == .single
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

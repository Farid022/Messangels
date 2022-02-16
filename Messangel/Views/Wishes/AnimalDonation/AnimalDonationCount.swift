//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationCount: View {
    private let donationTypes = [ClothsDonationType.single, ClothsDonationType.multiple]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationType.none
    @State private var showNote = false
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.animalDonation.single_animal_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "ANIMAUX", title: "Souhaitez-vous ajouter un ou plusieurs animaux ?", valid: $valid, destination: AnyView(AnimalDonationName(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .single ? "Un seul article" : "Plusieurs articles", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                                vm.animalDonation.single_animal = type == .single
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

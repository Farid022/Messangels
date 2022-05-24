//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationCount: View {
    @State private var showNote = false
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.animalDonation.single_animal_note.bound, attachements: $vm.attachements, noteAttachmentIds: $vm.animalDonation.single_animal_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 8.0, noteText: $vm.animalDonation.single_animal_note.bound, note: true, showNote: $showNote, menuTitle: "ANIMAUX", title: "Souhaitez-vous ajouter un ou plusieurs animaux ?", valid: .constant(vm.animalDonation.single_animal != nil), destination: AnyView(AnimalDonationName(vm: vm))) {
                HStack {
                    ForEach([true, false], id: \.self) { type in
                        ChoiceCard(text: type ? "Un seul article" : "Plusieurs articles", selected: .constant(vm.animalDonation.single_animal == type))
                            .onTapGesture {
                                vm.animalDonation.single_animal = type
                            }
                    }
                }
            }
        }
    }
}

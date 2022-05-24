//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ClothsDonationCount: View {
    @State private var showNote = false
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.clothDonation.single_clothing_note.bound, attachements: $vm.attachements, noteAttachmentIds:$vm.clothDonation.single_clothing_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 7.0, noteText: $vm.clothDonation.single_clothing_note.bound, note: true, showNote: $showNote, menuTitle: "Vêtements et accessoires", title: "Souhaitez-vous ajouter un ou plusieurs articles ?", valid: .constant(vm.clothDonation.single_clothing != nil), destination: AnyView(ClothsDonationName(vm: vm))) {
                HStack {
                    ForEach([true, false], id: \.self) { opt in
                        ChoiceCard(text: opt ? "Un seul article" : "Plusieurs articles", selected: .constant(vm.clothDonation.single_clothing == opt))
                            .onTapGesture {
                                vm.clothDonation.single_clothing = opt
                            }
                    }
                }
            }
        }
    }
}

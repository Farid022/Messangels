//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ObjectsDonationCount: View {
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
            FlowBaseView(noteText: $vm.objectDonation.single_object_note.bound, note: true, showNote: $showNote, menuTitle: "Objets", title: "Souhaitez-vous ajouter un ou plusieurs objets ?", valid: .constant(vm.objectDonation.single_object != nil), destination: AnyView(ObjectsDonationName(vm: vm))) {
                HStack {
                    ForEach([true, false], id: \.self) { type in
                        ChoiceCard(text: type ? "Un seul objet" : "Plusieurs objets", selected: .constant(vm.objectDonation.single_object == type))
                            .onTapGesture {
                                vm.objectDonation.single_object = type
                            }
                    }
                }
            }
        }
    }
}

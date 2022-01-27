//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct ClothsDonationCount: View {
    var donationTypes = [ClothsDonationType.single, ClothsDonationType.multiple]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationType.none
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = ClothDonationViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Vêtements et accessoires", title: "Souhaitez-vous ajouter un ou plusieurs articles ?", valid: $valid, destination: AnyView(ClothsDonationName(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .single ? "Un seul article" : "Plusieurs articles", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                                vm.clothDonation.single_clothing = type == .single
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

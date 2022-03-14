//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralRestingPlace: View {
    var funeralTypes = [FuneralRestPlace.funeral_place, FuneralRestPlace.residence]
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.location.resting_place_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 3.0, totalSteps: 6.0, noteText: $vm.location.resting_place_note.bound, note: true, showNote: $showNote, menuTitle: "Lieux", title: "Quel lieu de repos souhaiteriez-vous privilégier avant la cérémonie ?", valid: .constant(vm.location.resting_place != nil), destination: AnyView(FuneralConvoyRoute(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .funeral_place ? "Funérarium" : "Domicile", selected: .constant(vm.location.resting_place == type.rawValue))
                            .onTapGesture {
                                vm.location.resting_place = type.rawValue
                            }
                    }
                }
            }
        }
    }
}

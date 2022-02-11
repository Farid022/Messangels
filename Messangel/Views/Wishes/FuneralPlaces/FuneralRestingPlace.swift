//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralRestingPlace: View {
    var funeralTypes = [FuneralRestPlace.funeral_place, FuneralRestPlace.residence]
    @State private var valid = false
    @State private var selectedFuneral = FuneralRestPlace.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FuneralLocationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Lieux", title: "Quel lieu de repos souhaiteriez-vous privilégier avant la cérémonie ?", valid: $valid, destination: AnyView(FuneralConvoyRoute(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .funeral_place ? "Funérarium" : "Domicile", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
                                vm.location.resting_place = type.rawValue
                            }
                    }
                }
            }
            .onChange(of: selectedFuneral) { value in
                valid = selectedFuneral != .none
            }
        }
    }
}

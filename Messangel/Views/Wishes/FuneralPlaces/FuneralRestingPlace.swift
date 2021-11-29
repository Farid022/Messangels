//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct FuneralRestingPlace: View {
    private var funeralTypes = [FuneralRestPlace.funeral_place, FuneralRestPlace.residence]
    @State private var valid = false
    @State private var selectedFuneral = FuneralRestPlace.none
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Lieux", title: "Quel lieu de repos souhaiteriez-vous privilégier avant la cérémonie ?", valid: $valid, destination: AnyView(FuneralConvoyRoute())) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        FuneralTypeCard(text: type == .funeral_place ? "Funérarium" : "Domicile", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
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

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct SpiritualTraditionChoice: View {
    private var funeralTypes = [SpiritualType.non_religious, SpiritualType.religious]
    @State private var valid = false
    @State private var selectedFuneral = SpiritualType.none
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Spiritualité et traditions", title: "Quel type de cérémonie souhaitez-vous ?", valid: $valid, destination: AnyView(FuneralBurialPlace())) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        FuneralTypeCard(text: type == .non_religious ? "Non-religieuse" : "Religieuse ou philosophique", selected: .constant(selectedFuneral == type))
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

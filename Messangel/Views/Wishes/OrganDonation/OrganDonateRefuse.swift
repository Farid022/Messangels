//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct OrganDonateRefuse: View {
    private var funeralTypes = [FuneralBool.yes, FuneralBool.no]
    @State private var valid = false
    @State private var selectedFuneral = FuneralBool.none
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Avez-vous enregistré ce choix dans le registre national des refus ?", valid: $valid, destination: selectedFuneral == .yes ? AnyView(FuneralDoneView()) : AnyView(OrganDonateRefusalNotReg())) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        FuneralTypeCard(text: type == .yes ? "Oui" : "Non", selected: .constant(selectedFuneral == type))
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

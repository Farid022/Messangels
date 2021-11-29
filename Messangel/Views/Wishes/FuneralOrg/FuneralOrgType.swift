//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct FuneralOrgType: View {
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: "Avez-vous déjà choisi une entreprise funéraire ?", valid: $valid, destination: selectedFuneral == .yes ? AnyView(FuneralOrgContractType()) : AnyView(FuneralContractCompany())) {
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

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import SwiftUI

struct FuneralOrgType: View {
    var funeralTypes = [FuneralBool.yes, FuneralBool.no]
    @State private var valid = false
    @State private var selectedFuneral = FuneralBool.none
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = FuneralOrgViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: "Avez-vous déjà choisi une entreprise funéraire?", valid: $valid, destination: selectedFuneral == .yes ? AnyView(FuneralOrgContractType(vm: vm)) : AnyView(FuneralContractCompany(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .yes ? "Oui" : "Non", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
                                vm.funeralOrg.chose_funeral_home = type == .yes
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

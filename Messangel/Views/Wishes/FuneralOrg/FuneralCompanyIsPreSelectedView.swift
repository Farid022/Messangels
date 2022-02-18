//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
//Have you already chosen a funeral company?
struct FuneralCompanyIsPreSelectedView: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralOrgViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.funeralOrg.chose_funeral_home_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: "Avez-vous déjà choisi une entreprise funéraire?", valid: .constant(vm.funeralOrg.chose_funeral_home != nil), destination: vm.funeralOrg.chose_funeral_home ?? true ? AnyView(FuneralSelectCompanyView(vm: vm)) : AnyView(FuneralHaveContractView(vm: vm))) {
                HStack {
                    ForEach([true, false], id: \.self) { opt in
                        ChoiceCard(text: opt ? "Oui" : "Non", selected: .constant(vm.funeralOrg.chose_funeral_home == opt))
                            .onTapGesture {
                                vm.funeralOrg.chose_funeral_home = opt
                            }
                    }
                }
            }
        }
    }
}

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import SwiftUI
import NavigationStack

struct OrganDonateRefuse: View {
    var funeralTypes = [FuneralBool.yes, FuneralBool.no]
    @State private var valid = false
    @State private var selectedFuneral = FuneralBool.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction:true, customAction: {
                if !valid { return; }
                
                if selectedFuneral == .yes {
                    vm.create() { success in
                        if success {
                            navModel.pushContent("Avez-vous enregistré ce choix dans le registre national des refus ?") {
                                FuneralDoneView()
                            }
                        }
                    }
                    
                } else {
                    navModel.pushContent("Avez-vous enregistré ce choix dans le registre national des refus ?") {
                        OrganDonateRefusalNotReg(vm: vm)
                    }
                }
            },note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Avez-vous enregistré ce choix dans le registre national des refus ?", valid: $valid) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .yes ? "Oui" : "Non", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
                                vm.donation.register_to_national = type == .yes
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

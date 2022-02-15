//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateRefuse: View {
    private let funeralTypes = [FuneralBool.yes, FuneralBool.no]
    private let title = "Avez-vous enregistré ce choix dans le registre national des refus ?"
    @State private var selectedFuneral = FuneralBool.none
    @State private var showNote = false
    @State private var note = ""
    @State private var loading = false
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
                if selectedFuneral == .none { return; }
                
                if selectedFuneral == .yes {
                    if !vm.updateRecord {
                        vm.create() { success in
                            loading.toggle()
                            if success {
                                wishChoiceSuccessAction(title, navModel: navModel)
                            }
                        }
                    } else {
                        vm.update(id: vm.donations[0].id) { success in
                            loading.toggle()
                            if success {
                                wishChoiceSuccessAction(title, navModel: navModel)
                            }
                        }
                    }
                    
                } else {
                    navModel.pushContent(title) {
                        OrganDonateRefusalNotReg(vm: vm)
                    }
                }
            },note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: title, valid: .constant(selectedFuneral != .none)) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .yes ? "Oui" : "Non", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
                                vm.donation.register_to_national = type == .yes
                            }
                    }
                }
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

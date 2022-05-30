//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateRefuse: View {
    private let title = "Avez-vous enregistré ce choix dans le registre national des refus ?"
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.donation.register_to_national_note.bound, oldAttachedFiles:  $vm.donation.register_to_national_note_attachments, noteAttachmentIds: $vm.donation.register_to_national_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 4.0, isCustomAction:true, customAction: {                
                if let register_to_national = vm.donation.register_to_national, register_to_national {
                    loading.toggle()
                    if !vm.updateRecord {
                        vm.create() { success in
                            if success {
                                WishesViewModel.setProgress(tab: 4) { completed in
                                    loading.toggle()
                                    if completed {
                                        wishChoiceSuccessAction(title, navModel: navModel)
                                    }
                                }
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
            },note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la#science", title: title, valid: .constant(vm.donation.register_to_national != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { opt in
                        ChoiceCard(text: opt ? "Oui" : "Non", selected: .constant(vm.donation.register_to_national == opt))
                            .onTapGesture {
                                vm.donation.register_to_national = opt
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

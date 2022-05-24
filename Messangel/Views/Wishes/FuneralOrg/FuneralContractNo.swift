//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralContractNo: View {
    @EnvironmentObject var navModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FuneralOrgViewModel
    private let title = "Indiquez votre numéro de contrat obsèques"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.funeralOrg.company_contract_num_note.bound, attachements: $vm.attachements, noteAttachmentIds: $vm.funeralOrg.company_contract_num_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 4.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.create() { success in
                        if success {
                            WishesViewModel.setProgress(tab: 2) { completed in
                                loading.toggle()
                                if completed {
                                    successAction(title, navModel: navModel)
                                }
                            }
                        }
                    }
                } else {
                    vm.update(id: vm.funeralOrgs[0].id) { success in
                        loading.toggle()
                        if success {
                            successAction(title, navModel: navModel)
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: title, valid: .constant(vm.funeralOrg.company_contract_num != nil)) {
                TextField("Numéro de contrat obsèques", text: $vm.funeralOrg.company_contract_num)
                    .normalShadow()
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
            
        }
    }
}

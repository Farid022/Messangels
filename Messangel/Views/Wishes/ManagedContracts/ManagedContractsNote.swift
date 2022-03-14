//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractNote: View {
    @State private var showNote = false
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    @ObservedObject var vm: ContractViewModel
    var title = "Ajoutez des informations ou documents utiles (numéros de contrat, photos de pièces justificatives…)"
    
    fileprivate func createOrUpdateRecord() {
        if vm.updateRecord {
            vm.update(id: vm.contract.id ?? 0) { success in
                loading.toggle()
                if success {
                    navModel.popContent(String(describing: ManagedContractsList.self))
                    vm.getAll { _ in }
                }
            }
        } else {
            vm.create { success in
                if success && vm.contracts.isEmpty {
                    WishesViewModel.setProgress(tab: 15) { completed in
                        loading.toggle()
                        if completed {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                } else {
                    loading.toggle()
                    if success {
                        navModel.pushContent(title) {
                            FuneralDoneView()
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        FuneralNoteAttachCutomActionView(totalSteps: 4.0, showNote: $showNote, note: $vm.contract.contract_note, loading: $loading, attachements: $vm.attachements, noteAttachmentIds: $vm.contract.contract_note_attachment, menuTitle: wishesExtras[2].name, title: title) {
            loading.toggle()
            createOrUpdateRecord()
        }
    }
}

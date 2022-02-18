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
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.contract.contract_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                vm.create() { success in
                    loading.toggle()
                    if vm.updateRecord {
                        vm.update(id: vm.contract.id ?? 0) { success in
                            if success {
                                navModel.popContent("ManagedContractsList")
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
            },note: false, showNote: .constant(false), menuTitle: wishesExtras[2].name, title: title, valid: .constant(true)) {
                NoteView(showNote:$showNote, note: $vm.contract.contract_note)
            }
        }
    }
}

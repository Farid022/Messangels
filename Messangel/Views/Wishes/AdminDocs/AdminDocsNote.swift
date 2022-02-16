//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AdminDocsNote: View {
    @State private var showNote = false
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    @ObservedObject var vm: AdminDocViewModel
    var title = "Joignez des scans ou photos des documents avec l’outil note"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.adminDoc.document_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                if vm.updateRecord {
                    vm.update(id: vm.adminDoc.id ?? 0) { success in
                        if success {
                            navModel.popContent("AdminDocsList")
                            vm.getAll { _ in }
                        }
                    }
                } else {
                    vm.create { success in
                        if success && vm.adminDocs.isEmpty {
                            WishesViewModel.setProgress(tab: 14) { completed in
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
            },note: false, showNote: .constant(false), menuTitle: wishesExtras.first!.name, title: title, valid: .constant(true)) {
                NoteView(showNote:$showNote, note: $vm.adminDoc.document_note)
            }
        }
    }
}

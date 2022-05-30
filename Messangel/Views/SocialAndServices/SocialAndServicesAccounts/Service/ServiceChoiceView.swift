//
//  ServiceChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct ServiceChoiceView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showNote = false
    @ObservedObject var vm: OnlineServiceViewModel
    private let title = "QQue souhaitez-vous faire de votre compte?"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.accountFields.manageAccountNote.bound, oldAttachedFiles: $vm.accountFields.manageAccountNoteAttachments, noteAttachmentIds: $vm.accountFields.manageAccountNoteAttachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 5.0, totalSteps: 5.0, isCustomAction: true, customAction: {
                if let serviceId = vm.service.id {
                    vm.accountFields.onlineService = serviceId
                    vm.addAccountFields { success in
                        if success {
                            vm.account.accountId = vm.accountFields.id ?? 0
                            vm.addAccount { success in
                                if success {
                                    navigationModel.popContent(TabBarView.id)
                                }
                            }
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Ajouter un service en ligne", title: title, valid: .constant(vm.accountFields.deleteAccount != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { choice in
                        ChoiceCard(text: choice ? "Supprimer le compte" : "Gérer le compte (Note)", selected: .constant(vm.accountFields.deleteAccount == choice))
                            .onTapGesture {
                                vm.accountFields.deleteAccount = choice
                            }
                    }
                }
            }
        }
    }
}

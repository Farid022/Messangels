//
//  ServiceChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct SocialChoiceView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var choices = [SocialAccManageChoice.leaveMessage, SocialAccManageChoice.closeImediately]
    @State private var valid = false
    @State private var selectedChoice = SocialAccManageChoice.none
    @State private var showNote = false
    @ObservedObject var vm: OnlineServiceViewModel
    var title = "Comment souhaitez-vous que votre compte soit géré?"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.accountFields.manageAccountNote.bound, attachements: $vm.attachements, noteAttachmentIds: $vm.accountFields.manageAccountNoteAttachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 5.0, totalSteps: 5.0, isCustomAction: true, customAction: {
                vm.addAccountFields { success in
                    if success {
                        if selectedChoice == .leaveMessage {
                            vm.account.accountId = vm.accountFields.id ?? 0
                            navigationModel.pushContent(title) {
                                SocialNoteView(vm: vm)
                            }
                        } else {
                            navigationModel.popContent(TabBarView.id)
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: title, valid: $valid) {
                HStack {
                    ForEach(choices, id: \.self) { choice in
                        ChoiceCard(text: choice == .leaveMessage ? "Mettre un message puis clôturer " : "Clôturer le compte immédiatement", selected: .constant(selectedChoice == choice))
                            .onTapGesture {
                                selectedChoice = choice
                            }
                    }
                }
            }
            .onChange(of: selectedChoice) { value in
                valid = selectedChoice != .none
            }
        }
    }
}

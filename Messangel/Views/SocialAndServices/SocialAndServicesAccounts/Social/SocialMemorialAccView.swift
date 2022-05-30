//
//  ServiceChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct SocialMemorialAccView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showNote = false
    @State private var loading = false
    @State private var note = ""
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.account.memorialAccountNote.bound, oldAttachedFiles: $vm.account.memorialAccountNoteAttachments, noteAttachmentIds: $vm.account.memorialAccountNoteAttachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 5.0, totalSteps: 5.0, isCustomAction: true, customAction: {
                loading.toggle()
                Task {
                    if vm.socialAccPic.cgImage != nil {
                        self.vm.account.lastPostImage = await uploadImage(vm.socialAccPic, type: "social_acc").0
                    }
                    vm.addAccount { success in
                        loading.toggle()
                        if success {
                            navigationModel.popContent(TabBarView.id)
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: "\(vm.service.name) - Acceptez-vous qu’un proche créée un compte commémoratif sur ce réseau?", valid: .constant(vm.account.memorialAccount != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { choice in
                        ChoiceCard(text: choice ? "Oui" : "Non", selected: .constant(vm.account.memorialAccount == choice))
                            .onTapGesture {
                                vm.account.memorialAccount = choice
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

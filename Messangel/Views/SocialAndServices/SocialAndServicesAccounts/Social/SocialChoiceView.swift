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
    var keyAccRegChoices = [KeyAccChoice.remove, KeyAccChoice.manage]
    @State private var valid = false
    @State private var selectedChoice = KeyAccChoice.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: OnlineServiceViewModel
    var title = "Comment souhaitez-vous que votre compte soit géré?"
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                vm.addAccountFields { success in
                    if success {
                        if selectedChoice == .remove {
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
                    ForEach(keyAccRegChoices, id: \.self) { choice in
                        ChoiceCard(text: choice == .remove ? "Mettre un message puis clôturer " : "Clôturer le compte immédiatement", selected: .constant(selectedChoice == choice))
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

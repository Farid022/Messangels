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
    var keyAccRegChoices = [KeyAccChoice.remove, KeyAccChoice.manage]
    @State private var valid = false
    @State private var selectedChoice = KeyAccChoice.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: OnlineServiceViewModel
    var title = "QQue souhaitez-vous faire de votre compte?"
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
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
            }, note: true, showNote: $showNote, menuTitle: "Ajouter un service en ligne", title: title, valid: $valid) {
                HStack {
                    ForEach(keyAccRegChoices, id: \.self) { choice in
                        ChoiceCard(text: choice == .remove ? "Supprimer le compte" : "Gérer le compte (Note)", selected: .constant(selectedChoice == choice))
                            .onTapGesture {
                                selectedChoice = choice
                                vm.accountFields.deleteAccount = choice == .remove
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

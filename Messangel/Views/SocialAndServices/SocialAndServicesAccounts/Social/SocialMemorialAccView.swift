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
    var keyAccRegChoices = [KeyAccChoice.remove, KeyAccChoice.manage]
    @State private var valid = false
    @State private var selectedChoice = KeyAccChoice.none
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                vm.addAccount { success in
                    if success {
                        navigationModel.popContent(TabBarView.id)
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: "\(vm.service.name) - Acceptez-vous qu’un proche créée un compte commémoratif sur ce réseau?", valid: $valid) {
                HStack {
                    ForEach(keyAccRegChoices, id: \.self) { choice in
                        ChoiceCard(text: choice == .remove ? "Oui" : "Non", selected: .constant(selectedChoice == choice))
                            .onTapGesture {
                                selectedChoice = choice
                                vm.account.memorialAccount = choice == .remove
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

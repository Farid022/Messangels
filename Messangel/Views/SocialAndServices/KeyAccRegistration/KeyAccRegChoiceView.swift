//
//  KeyAccRegChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct KeyAccRegChoiceView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var selectedChoice = KeyAccChoice.none
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: KeyAccViewModel
    var keyAccCase: KeyAccCase
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                if valid {
                    vm.addPrimaryEmailAcc { success in
                        if success {
                            if keyAccCase == .register {
                                navigationModel.pushContent("\(vm.keyEmailAcc.email) - Que souhaitez-vous faire de ce compte après votre départ?") {
                                    KeyAccRegPhoneNameView()
                                }
                            } else {
                                navigationModel.popContent("navigationModel")
                            }
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Comptes-clés", title: "\(vm.keyEmailAcc.email) - Que souhaitez-vous faire de ce compte après votre départ?", valid: $valid) {
                
                KeyAccRegChoiceChildView(selectedChoice: $selectedChoice, vm: vm)
            }
            .onChange(of: selectedChoice) { value in
                valid = selectedChoice != .none
            }
        }
    }
}

struct KeyAccRegChoiceChildView: View {
    var keyAccRegChoices = [KeyAccChoice.remove, KeyAccChoice.manage]
    @Binding var selectedChoice: KeyAccChoice
    @ObservedObject var vm: KeyAccViewModel
    var body: some View {
        HStack {
            ForEach(keyAccRegChoices, id: \.self) { choice in
                ChoiceCard(text: choice == .remove ? "Supprimer le compte" : "Gérer le compte (Note)", selected: .constant(selectedChoice == choice))
                    .onTapGesture {
                        selectedChoice = choice
                        vm.keyEmailAcc.deleteAccount = choice == .remove
                    }
            }
        }
    }
}

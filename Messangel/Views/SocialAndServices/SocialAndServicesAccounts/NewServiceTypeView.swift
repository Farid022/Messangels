//
//  ServiceChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct NewServiceTypeView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var choices = [KeyAccChoice.remove, KeyAccChoice.manage]
    @State private var valid = false
    @State private var selectedChoice = KeyAccChoice.none
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = OnlineServiceViewModel()
    
    var title = "S'agit-il d'un service en ligne ou d'un réseau social ?"
    var name: String
    
    var body: some View {
        FlowBaseView(note: true, showNote: $showNote, menuTitle: "Ajouter un service en ligne", title: title, valid: $valid, destination: AnyView(NewServiceWebSiteView(vm: vm, name: name))) {
            HStack {
                ForEach(choices, id: \.self) { choice in
                    ChoiceCard(text: choice == .remove ? "Service en ligne" : "Réseau social", selected: .constant(selectedChoice == choice))
                        .onTapGesture {
                            selectedChoice = choice
                            if choice == .remove {
                                vm.service.type = "listing"
                            } else {
                                vm.service.type = "social"
                            }
                        }
                }
            }
        }
        .onChange(of: selectedChoice) { value in
            valid = selectedChoice != .none
        }
    }
}

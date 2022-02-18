//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import NavigationStack
import SwiftUI

struct DeathAnnounceContacts: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var showNote = false
    @State private var loading = false
    @State private var note = ""
    @ObservedObject var vm: PriorityContactsViewModel
    var title = "Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité."
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.addPriorityContacts() { success in
                        if success {
                            WishesViewModel.setProgress(tab: 6) { completed in
                                loading.toggle()
                                if completed {
                                    successAction(title, navModel: navigationModel)
                                }
                            }
                        }
                    }
                } else {
                    vm.update(id: vm.priorities[0].id) { success in
                        loading.toggle()
                        if success {
                            successAction(title, navModel: navigationModel)
                        }
                    }
                }
                
            },note: true, showNote: $showNote, menuTitle: "Diffusion de la nouvelle", title: title, valid: .constant(!vm.priorityContacts.contact.isEmpty)) {
                if vm.priorityContacts.contact.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.") {
                            DeathAnnounceContactsList(vm: vm)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: vm.priorityContacts.contact.count), alignment: .leading, spacing: 16.0) {
                        ForEach(vm.contacts, id: \.self) { contact in
                            FuneralCapsuleView(name: contact.first_name + " " + contact.last_name) {
                                vm.priorityContacts.contact.remove(at: vm.priorityContacts.contact.firstIndex(of: contact.id)!)
                                vm.contacts.remove(at: vm.contacts.firstIndex(of: contact)!)
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
}

func successAction(_ title: String, navModel: NavigationModel) {
    navModel.pushContent(title) {
        FuneralDoneView()
    }
}

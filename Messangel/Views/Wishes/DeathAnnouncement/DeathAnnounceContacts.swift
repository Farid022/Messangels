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
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedContacts = [Contact]()
    @StateObject private var vm = PriorityContactsViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                if !valid {
                    return;
                }
                vm.addPriorityContacts() { success in
                    if success {
                        navigationModel.pushContent("Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.") {
                            FuneralDoneView()
                        }
                    }
                }
                
            },note: true, showNote: $showNote, menuTitle: "Diffusion de la nouvelle", title: "Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.", valid: .constant(!vm.priorityContacts.contact.isEmpty)) {
                if vm.priorityContacts.contact.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.") {
                            DeathAnnounceContactsList(selectedContacts: $selectedContacts, vm: vm)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    ForEach(selectedContacts, id: \.self) { contact in
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: vm.priorityContacts.contact.count), spacing: 16.0) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 170, height: 56)
                            .foregroundColor(.white)
                            .thinShadow()
                            .overlay(HStack {
                                Text(contact.first_name)
                                    .font(.system(size: 14))
                                Button(action: { // FIX: use 1 of the two arrays only
                                    vm.priorityContacts.contact.remove(at: vm.priorityContacts.contact.firstIndex(of: contact.id)!)
                                    selectedContacts.remove(at: selectedContacts.firstIndex(of: contact)!)
                                }, label: {
                                    Image("ic_btn_remove")
                                })
                            })
                        }
                    }
                }
            }
            
        }
    }
}

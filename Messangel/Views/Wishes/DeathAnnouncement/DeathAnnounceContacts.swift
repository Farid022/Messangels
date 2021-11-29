//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct DeathAnnounceContacts: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedContacts = [String]()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Diffusion de la nouvelle", title: "Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.", valid: .constant(!selectedContacts.isEmpty), destination: AnyView(FuneralDoneView())) {
                if selectedContacts.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Ajoutez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité.") {
                            DeathAnnounceContactsList(selectedContacts: $selectedContacts)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    ForEach(selectedContacts, id: \.self) { contact in
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: selectedContacts.count), spacing: 16.0) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 170, height: 56)
                            .foregroundColor(.white)
                            .thinShadow()
                            .overlay(HStack {
                                Text(contact)
                                    .font(.system(size: 14))
                                Button(action: {
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
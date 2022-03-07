//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct AnimalDonationContact: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedContact = Contact(id: 0, user: getUserId(), first_name: "", last_name: "", email: "", phone_number: "", legal_age: true)
    @ObservedObject var vm: AnimalDonatiopnViewModel

    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "ANIMAUX", title: "Sélectionnez un contact à qui confier *votre animal *vos animaux", valid: .constant(!selectedContact.first_name.isEmpty), destination: AnyView(AnimalDonationPic(vm: vm))) {
                if selectedContact.first_name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui confier *votre animal *vos animaux") {
                            AnimalDonationContactsList(selectedContact: $selectedContact, vm: vm)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 56)
                        .foregroundColor(.white)
                        .thinShadow()
                        .overlay(HStack {
                            Text("\(selectedContact.first_name) \(selectedContact.last_name)")
                                .font(.system(size: 14))
                            Button(action: {
                                selectedContact.first_name.removeAll()
                            }, label: {
                                Image("ic_btn_remove")
                            })
                        })
                }
            }
            
        }
    }
}

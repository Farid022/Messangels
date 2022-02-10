//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct DeathAnnounceContactsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un contact"
    @State private var isEditing = false
    @StateObject private var contactsVM = ContactViewModel()
    @Binding var selectedContacts: [Contact]
    @ObservedObject var vm: PriorityContactsViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: 150)
                .overlay(
                    VStack {
                        HStack {
                            BackButton(icon:"chevron.down")
                            .padding(.leading)
                        Spacer()
                        Text("Sélectionnez au moins une personne")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                        HStack {
                            TextField(placeholder, text: $searchString)
                                .textFieldStyle(MyTextFieldStyle())
                                .onTapGesture {
                                    isEditing = true
                                    placeholder = ""
                                }
                                .if(!isEditing) {$0.overlay(
                                    HStack {
                                        Image("ic_search")
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 8)
                                    }
                                )}
                            Button(action: {}, label: {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .overlay(Image("ic_sort"))
                            })
                        }
                        .padding()
                    }, alignment: .bottom)
            ScrollView(showsIndicators: false) {
                    
    //                HStack(spacing: 2) {
    //                    Image(systemName: "arrow.up.arrow.down")
    //                        .foregroundColor(.white)
    //                        .padding(.trailing, 5)
    //                    Button(action: {
    ////                        vm.contacts.sort(by: { $0.first_name < $1.first_name })
    //                    }) {
    //                        Text("Prénom")
    //                            .foregroundColor(.white)
    //                            .underline()
    //                    }
    //                    Text("|")
    //                        .foregroundColor(.white)
    //                    Button(action: {
    ////                        vm.contacts.sort(by: { $0.last_name < $1.last_name })
    //                    }) {
    //                        Text("Nom")
    //                            .foregroundColor(.white)
    //                            .underline()
    //                    }
    //                    Spacer()
    //                }
                    
                    Spacer().frame(height: 20)
                    Button(action: {
//                        contacts.append("Prénom Nom")
                    }) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.accentColor)
                            .frame(height: 56)
                            .overlay(
                                HStack {
                                    Image("ic_add-user")
                                        .padding(.leading)
                                    Text("Nouvel contact")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            )
                    }
                    .padding(.bottom)
                ForEach(contactsVM.contacts.filter({ searchString.isEmpty ? true : $0.first_name.contains(searchString)}), id:\.self) { contact in
                    ListItemView(name: "\(contact.first_name) \(contact.last_name)", image: "ic_contact")
                                .onTapGesture {
                                    if !selectedContacts.contains(contact) {
                                        selectedContacts.append(contact)
                                        vm.priorityContacts.contact.append(contact.id)
                                    }
                                    navigationModel.hideTopView()
                                }
                        }
            }
            .padding()
        }
        .task() {
            contactsVM.getContacts()
        }
            
    }
}

//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct MsgGroupContactsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un contact"
    @State private var isEditing = false
    @State private var refreshList = false
    @State private var loading = false
    @StateObject private var contactsVM = ContactViewModel()
    @ObservedObject var vm: GroupViewModel
    
    var body: some View {
        ZStack {
            NavigationStackView(String(describing: Self.self)) {
                VStack(spacing: 0.0) {
                    Color.accentColor
                        .ignoresSafeArea()
                        .frame(height: 150)
                        .overlay(
                            VStack {
                                HStack {
                                    BackButton(viewId: TabBarView.id ,icon:"chevron.down")
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
                            navigationModel.presentContent(String(describing: Self.self)) {
                                CreateContactView(vm: contactsVM, refresh: $refreshList)
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.accentColor)
                                .frame(height: 56)
                                .overlay(
                                    HStack {
                                        Image("ic_add-user")
                                            .padding(.leading)
                                        Text("Nouveau contact")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                )
                        }
                        .padding(.bottom)
                        ForEach(contactsVM.contacts.filter({ searchString.isEmpty ? true : $0.first_name.contains(searchString) || $0.last_name.contains(searchString)}), id:\.self) { contact in
                            ListItemView(name: "\(contact.first_name) \(contact.last_name)", image: "ic_contact") {
                                if var groupContacts = vm.group.group_contacts {
                                    if groupContacts.contains(contact.id) {
                                        return
                                    }
                                    vm.groupContacts.append(contact)
                                    groupContacts.append(contact.id)
                                    vm.group.group_contacts = groupContacts
                                    loading.toggle()
                                    vm.update(id: vm.group.id ?? 0) { success in
                                        if success {
                                            contactsVM.contacts.removeAll(where: { $0.id == contact.id })
                                            loading.toggle()
                                        }
                                    }
                                } else {
                                    vm.group.group_contacts = [contact.id]
                                    loading.toggle()
                                    vm.update(id: vm.group.id ?? 0) { success in
                                        if success {
                                            contactsVM.contacts.removeAll(where: { $0.id == contact.id })
                                            loading.toggle()
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            if loading {
                UpdatingView()
            }
        }
        .task() {
            contactsVM.getContacts()
        }
        .onChange(of: refreshList) { _ in
            contactsVM.getContacts()
        }
    }
}

struct UpdatingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.white)
                    .frame(width: 236, height: 51)
                Text("Ajouté")
                    .font(.system(size: 17), weight: .semibold)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

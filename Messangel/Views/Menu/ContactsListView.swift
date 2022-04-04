//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct ContactsListView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un contact"
    @State private var isEditing = false
    @State private var refreshList = false
    @StateObject private var vm = ContactViewModel()
    
    var body: some View {
        NavigationStackView("ContactsListView") {
            MenuBaseView(title: "Liste de contacts") {
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
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.accentColor)
                        .frame(width: 56, height: 56)
                        .overlay(Button(action: {
                            navigationModel.pushContent("ContactsListView") {
                                CreateContactView(vm: vm, refresh: $refreshList)
                            }
                        }) {
                            Image("ic_contact-add")
                        })
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .padding(-16)
                Spacer().frame(height: 15)
                HStack(spacing: 2) {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.white)
                        .padding(.trailing, 5)
                    Button(action: {
                        vm.contacts.sort(by: { $0.first_name < $1.first_name })
                    }) {
                        Text("Prénom")
                            .foregroundColor(.white)
                            .underline()
                    }
                    Text("|")
                        .foregroundColor(.white)
                    Button(action: {
                        vm.contacts.sort(by: { $0.last_name < $1.last_name })
                    }) {
                        Text("Nom")
                            .foregroundColor(.white)
                            .underline()
                    }
                    Spacer()
                }
                .padding()
                .background(Color.gray)
                .padding(.horizontal, -16)
                Spacer().frame(height: 30)
                ForEach(vm.contacts.filter({ searchString.isEmpty ? true : $0.first_name.contains(searchString)}), id:\.self) { contact in
                    ContactView(lastName: contact.last_name, firstName: contact.first_name)
                        .onTapGesture {
                            navigationModel.pushContent("ContactsListView") {
                                ContactEditView(vm: vm, contact: .constant(contact))
                            }
                        }
                }
            }
            .onDidAppear() {
                vm.getContacts()
            }
            .onChange(of: refreshList) { _ in
                vm.getContacts()
            }
        }
    }
}

struct ContactView: View {
    var lastName = ""
    var firstName = ""
    
    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(height: 56)
            .normalShadow()
            .overlay(HStack{
                Image(systemName: "person.fill")
                    .padding(.leading)
                Text(lastName)
                Text(firstName)
                    .fontWeight(.semibold)
                Spacer()
            })
            .padding(.bottom)
    }
}

//struct ContactsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactsListView()
//    }
//}

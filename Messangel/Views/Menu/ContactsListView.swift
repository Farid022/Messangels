//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct ContactsListView: View {
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un contact"
    @State private var isEditing = false
    
    var body: some View {
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
                    .overlay(NavigationLink(destination: CreateContactView()) {
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
                Button(action: {}) {
                    Text("Prénom")
                        .foregroundColor(.white)
                        .underline()
                }
                Text("|")
                    .foregroundColor(.white)
                Button(action: {}) {
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
            ContactView(lastName: "Lucie", firstName: "Carnero")
            ContactView(lastName: "Marianne", firstName: "Milon")
            ContactView(lastName: "Mourad", firstName: "Essafi")
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
            .shadow(color: .gray.opacity(0.2), radius: 10)
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

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsListView()
        }
    }
}

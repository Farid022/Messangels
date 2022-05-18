//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import NavigationStack

struct ContactEditView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: ContactViewModel
    @Binding var contact: Contact
    
    var body: some View {
        MenuBaseView(title:"\(contact.first_name) \(contact.last_name)") {
            HStack {
                Text("\(contact.first_name) \(contact.last_name)")
                    .font(.system(size: 20), weight: .bold)
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("", text: $contact.first_name)
                TextField("", text: $contact.last_name)
                TextField("", text: $contact.email)
                TextField("", text: $contact.phone_number)
            }
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
            .padding(.bottom)
            Text("Si cette personne est encore mineure au moment de votre décès, vos messages seront envoyés à vos Anges-gardiens.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Button("Enregistrer les modifications") {
                vm.contact = contact
                vm.updateContact(contactId: contact.id) { success in
                    navigationModel.hideTopView()
                }
            }
            .buttonStyle(MyButtonStyle(padding: 20, foregroundColor: .white, backgroundColor: .accentColor))
            .padding(.bottom)
            Button("Supprimer ce contact") {
                vm.delete(contactId: self.contact.id) { success in
                    navigationModel.hideTopView()
                }
            }
            .buttonStyle(MyButtonStyle(padding: 20, foregroundColor: .white, backgroundColor: .black))
            .padding(.bottom)
        }
    }
}

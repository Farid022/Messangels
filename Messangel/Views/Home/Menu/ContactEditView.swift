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
    @EnvironmentObject var auth: Auth
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
            .textFieldStyle(MyTextFieldStyle(editable: true))
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Text("Si cette personne est encore mineure au moment de votre décès, vos messages seront envoyés à vos Anges-gardiens.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Button("Supprimer ce contact") {
                vm.delete(userId: auth.user.id ?? 0, contactId: self.contact.id) { success in
                    if success {
                        navigationModel.hideTopView()
                    } else {
                        
                    }
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
            .padding(.bottom)
        }
    }
}

//struct ContactEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactEditView(contact: Binding<Contact>)
//    }
//}

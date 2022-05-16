//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import NavigationStack

struct OrganizationEditView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: OrgViewModel
    @Binding var org: Organization
    
    var body: some View {
        MenuBaseView(title: org.name) {
            HStack {
                Text(org.name)
                    .font(.system(size: 20), weight: .bold)
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("", text: $org.name)
                TextField("", text: $org.emailAddress.bound)
                TextField("", text: $org.phoneNumber.bound)
            }
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
            .padding(.bottom)
            Button("Enregistrer les modifications") {
                
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
            .padding(.bottom)
            Button("Supprimer ce organisme") {
//                vm.delete(userId: getUserId(), contactId: self.contact.id) { success in
//                    if success {
//                        navigationModel.hideTopView()
//                    } else {
//
//                    }
//                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
            .padding(.bottom)
        }
    }
}

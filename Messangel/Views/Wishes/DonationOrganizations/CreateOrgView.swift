//
//  CreateOrgView.swift
//  Messangel
//
//  Created by Saad on 1/25/22.
//

import SwiftUI
import NavigationStack

struct CreateOrgView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject var vm = OrgViewModel()
    @State private var isValid = false
    @State private var alert = false
    @State private var loading = false
    var type: String
    @Binding var refresh: Bool
    
    var body: some View {
        MenuBaseView(height: 60, title: "Nouvel organisme") {
            HStack {
                Text("Nouvel organisme")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 20)
            Group {
                TextField("Nom de l’organisme (obligatoire)", text: $vm.newOrg.name)
                TextField("Adresse mail (recommandé)", text: $vm.newOrg.emailAddress)
                    .keyboardType(.emailAddress)
                TextField("Numéro de téléphone (recommandé)", text: $vm.newOrg.phoneNumber)
                    .keyboardType(.phonePad)
                TextField("Nom d’un contact", text: $vm.newOrg.contactName)
                TextField("Adresse", text: $vm.newOrg.address)
                TextField("Code postal", text: $vm.newOrg.postalCode)
                TextField("Ville", text: $vm.newOrg.city)
                TextField("Site web", text: $vm.newOrg.website)
            }
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
            .padding(.bottom)
            Spacer().frame(height: 20)
            Button(action: {
                if isValid {
                    vm.newOrg.type = type
                    loading.toggle()
                    vm.create { success in
                        loading.toggle()
                        if success {
                            refresh.toggle()
                            navigationModel.hideTopViewWithReverseAnimation()
                        } else {
                            alert.toggle()
                        }
                    }
                }
            }){
                HStack {
                    Image("ic_add-user")
                    Text("Créer")
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
            if loading {
                Loader()
                    .padding(.top)
            }
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(vm.apiError.error), message: Text(vm.apiError.error_description))
        })
        .onChange(of: vm.newOrg.name) { value in
            isValid = !value.isEmpty
        }
        
    }
}

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var selectedCompany = Organization(id: 0, name: "", type: "1", user: getUserId())
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Objets", title: "Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets", valid: .constant(!selectedCompany.name.isEmpty), destination: AnyView(ObjectsDonationPic(vm: vm))) {
                if selectedCompany.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets") {
                            ObjectsDonationOrgList(selectedCompany: $selectedCompany, vm: vm)
                        }
                    }, label: {
                        Image("list_org")
                    })
                } else {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 56)
                        .foregroundColor(.white)
                        .thinShadow()
                        .overlay(HStack {
                            Text(selectedCompany.name)
                                .font(.system(size: 14))
                            Button(action: {
                                selectedCompany.name.removeAll()
                            }, label: {
                                Image("ic_btn_remove")
                            })
                        })
                }
            }
            
        }
    }
}

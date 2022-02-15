//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationContact: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var selectedContact = Contact(id: 0, user: getUserId(), first_name: "", last_name: "", email: "", phone_number: "", legal_age: true)
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Vêtements et accessoires", title: "Sélectionnez un contact à qui donner *cet article *ces articles", valid: .constant(!selectedContact.first_name.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if selectedContact.first_name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet article *ces articles") {
                            ClothsDonationContactsList(selectedContact: $selectedContact, vm: vm)
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

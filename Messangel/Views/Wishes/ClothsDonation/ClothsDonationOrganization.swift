//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedCompany = Organization(id: 0, name: "", type: "2", user: getUserId())
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Vêtements et accessoires", title: "Sélectionnez un contact à qui donner *cet article *ces articles", valid: .constant(!selectedCompany.name.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if selectedCompany.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet article *ces articles") {
                            ClothsDonationOrgList(vm: vm, selectedCompany: $selectedCompany)
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

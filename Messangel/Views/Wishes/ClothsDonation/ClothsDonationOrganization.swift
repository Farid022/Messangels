//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct ClothsDonationOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedCompany = ""
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Vêtements et accessoires", title: "Sélectionnez un contact à qui donner *cet article *ces articles", valid: .constant(!selectedCompany.isEmpty), destination: AnyView(ClothsDonationPic())) {
                if selectedCompany.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet article *ces articles") {
                            ClothsDonationOrgList(selectedCompany: $selectedCompany)
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
                            Text(selectedCompany)
                                .font(.system(size: 14))
                            Button(action: {
                                selectedCompany.removeAll()
                            }, label: {
                                Image("ic_btn_remove")
                            })
                        })
                }
            }
            
        }
    }
}

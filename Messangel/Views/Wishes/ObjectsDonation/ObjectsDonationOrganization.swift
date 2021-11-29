//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct ObjectsDonationOrganization: View {
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Objets", title: "Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets", valid: .constant(!selectedCompany.isEmpty), destination: AnyView(ObjectsDonationPic())) {
                if selectedCompany.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets") {
                            ObjectsDonationOrgList(selectedCompany: $selectedCompany)
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

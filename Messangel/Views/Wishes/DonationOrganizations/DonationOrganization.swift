//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct DonationOrganization: View {
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
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Dons et collectes", title: "Indiquez l’organisme auquel vous souhaitez faire un don", valid: .constant(!selectedCompany.isEmpty), destination: AnyView(DonationOrgNote())) {
                if selectedCompany.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Indiquez l’organisme auquel vous souhaitez faire un don") {
                            DonationOrgList(selectedCompany: $selectedCompany)
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

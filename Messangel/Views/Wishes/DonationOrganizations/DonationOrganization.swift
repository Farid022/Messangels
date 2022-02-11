//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct DonationOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedCompany = Organization(id: 0, name: "", type: "3", user: getUserId())
    @StateObject private var vm = DonationOrgViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Dons et collectes", title: "Indiquez l’organisme auquel vous souhaitez faire un don", valid: .constant(!selectedCompany.name.isEmpty), destination: AnyView(DonationOrgNote(vm: vm))) {
                if selectedCompany.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Indiquez l’organisme auquel vous souhaitez faire un don") {
                            DonationOrgList(selectedCompany: $selectedCompany, vm: vm)
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

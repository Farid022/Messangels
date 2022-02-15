//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var selectedCompany = Organization(id: 0, name: "", type: "5", user: getUserId())
    @ObservedObject var vm: AnimalDonatiopnViewModel

    
    var body: some View {
        ZStack {
//            if showNote {
//               FuneralNote(showNote: $showNote, note: $note)
//                .zIndex(1.0)
//                .background(.black.opacity(0.8))
//                .edgesIgnoringSafeArea(.top)
//            }
            FlowBaseView(menuTitle: "ANIMAUX", title: "Indiquez le nom de l’organisme auquel confier *votre animal *vos animaux", valid: .constant(!selectedCompany.name.isEmpty), destination: AnyView(AnimalDonationPic(vm: vm))) {
                if selectedCompany.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Indiquez le nom de l’organisme auquel confier *votre animal *vos animaux") {
                            AnimalDonationOrgList(selectedCompany: $selectedCompany, vm: vm)
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

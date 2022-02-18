//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralSelectCompanyView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FuneralOrgViewModel
    private let title = "Indiquez l’entreprise funéraire que vous avez choisie"
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: title, valid: .constant(vm.funeralOrg.funeral_company != nil), destination: AnyView(FuneralContractNo(vm: vm))) {
                if vm.funeralOrg.funeral_company == nil {
                    Button(action: {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.funeralOrg.funeral_company.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 6)
                        }
                    }, label: {
                        Image("list_org")
                    })
                } else {
                    FuneralCapsuleView(name: vm.orgName) {
                        vm.funeralOrg.funeral_company = nil
                        vm.orgName.removeAll()
                    }
                }
            }
            
        }
    }
}

struct FuneralCapsuleView: View {
    var name: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 56)
                .foregroundColor(.white)
                .thinShadow()
            HStack(spacing: 20) {
                Text(name)
                    .font(.system(size: 14))
                Button(action: {
                    action()
                }, label: {
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                        Image("ic_remove")
                    }
                })
                    .thinShadow()
            }
            .padding(.horizontal)
        }
        .fixedSize()
    }
}

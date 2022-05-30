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
    @ObservedObject var vm: FuneralOrgViewModel
    private let title = "Indiquez l’entreprise funéraire que vous avez choisie"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.funeralOrg.funeral_company_note.bound, oldAttachedFiles: $vm.funeralOrg.funeral_company_note_attachments, noteAttachmentIds: $vm.funeralOrg.funeral_company_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 4.0, noteText: $vm.funeralOrg.funeral_company_note.bound, note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: title, valid: .constant(vm.funeralOrg.funeral_company != nil), destination: AnyView(FuneralHaveCompanyContractView(vm: vm, companyName: vm.orgName))) {
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

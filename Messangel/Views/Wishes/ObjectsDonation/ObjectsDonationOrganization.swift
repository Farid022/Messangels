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
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Objets", title: "Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets", valid: .constant(!vm.orgName.isEmpty), destination: AnyView(ObjectsDonationPic(vm: vm))) {
                if vm.orgName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un organisme à qui donner *cet objet *ce groupe d’objets") {
                            SingleOrgSelectionList(orgId: $vm.objectDonation.organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 1)
                        }
                    }, label: {
                        Image("list_org")
                    })
                } else {
                    FuneralCapsuleView(name: vm.orgName) {
                        vm.orgName.removeAll()
                        vm.objectDonation.organization_detail = nil
                    }
                }
            }
            
        }
    }
}

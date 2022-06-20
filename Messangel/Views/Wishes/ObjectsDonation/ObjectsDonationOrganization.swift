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
    var title: String {
        return "Sélectionnez un organisme à qui donner\(vm.objectDonation.single_object! ? "cet objet" : "ce groupe d’objets")"
    }
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 5.0, totalSteps: 7.0, menuTitle: "Objets", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(ObjectsDonationPic(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.objectDonation.organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 1)
                        }
                    }
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

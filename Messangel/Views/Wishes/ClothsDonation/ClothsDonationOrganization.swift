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
    @ObservedObject var vm: ClothDonationViewModel
    var title: String {
        return "Sélectionnez un contact à qui donner \(vm.clothDonation.single_clothing! ? "cet article" : "ces articles")"
    }
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 5.0, totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.clothDonation.clothing_organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 2)
                        }
                    }
                } else {
                    FuneralCapsuleView(name: vm.orgName) {
                        vm.orgName.removeAll()
                        vm.clothDonation.clothing_organization_detail = nil
                    }
                }
            }
            
        }
    }
}

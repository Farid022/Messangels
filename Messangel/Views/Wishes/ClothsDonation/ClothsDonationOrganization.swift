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
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Vêtements et accessoires", title: "Sélectionnez un contact à qui donner *cet article *ces articles", valid: .constant(!vm.orgName.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if vm.orgName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet article *ces articles") {
                            SingleOrgSelectionList(orgId: $vm.clothDonation.clothing_organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 2)
                        }
                    }, label: {
                        Image("list_org")
                    })
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

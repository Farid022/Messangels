//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgsSelectionView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @ObservedObject var vm: DonationOrgViewModel

    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 2.0, totalSteps: 3.0, menuTitle: "Dons et collectes", title: "Indiquez l’organisme auquel vous souhaitez faire un don", valid: .constant(!vm.orgName.isEmpty), destination: AnyView(DonationOrgNote(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent("Indiquez l’organisme auquel vous souhaitez faire un don") {
                            SingleOrgSelectionList(orgId: $vm.donationOrg.donation_organization, orgName: $vm.orgName, orgType: 3)
                        }
                    }
                } else {
                    FuneralCapsuleView(name: vm.orgName) {
                        vm.orgName.removeAll()
                    }
                }
            }
            
        }
    }
}

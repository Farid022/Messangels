//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractOrganization: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @ObservedObject var vm: ContractViewModel
    var title: String {
        return "\(vm.contract.contract_name) - Indiquez l’organisme qui gère ce contrat"
    }
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 3.0, totalSteps: 4.0, menuTitle: "Contrats à gérer", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(ManagedContractNote(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.contract.contract_organization, orgName: $vm.orgName, orgType: 4)
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

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
    @ObservedObject var vm: AnimalDonatiopnViewModel
    var title: String {
        return "Indiquez le nom de l’organisme auquel confier \(vm.animalDonation.single_animal! ? "votre animal" : "vos animaux")"
    }
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 7.0, totalSteps: 8.0, menuTitle: "ANIMAUX", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(AnimalDonationNote(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.animalDonation.animal_organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 5)
                        }
                    }
                } else {
                    HStack {
                        FuneralCapsuleView(name: vm.orgName) {
                            vm.orgName.removeAll()
                            vm.animalDonation.animal_organization_detail = nil
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}

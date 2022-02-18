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
    @ObservedObject var vm: AnimalDonatiopnViewModel
    private let title = "Indiquez le nom de l’organisme auquel confier *votre animal *vos animaux"
    
    var body: some View {
        ZStack {
//            if showNote {
//               FuneralNote(showNote: $showNote, note: $note)
//                .zIndex(1.0)
//                .background(.black.opacity(0.8))
//                .edgesIgnoringSafeArea(.top)
//            }
            FlowBaseView(menuTitle: "ANIMAUX", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(AnimalDonationPic(vm: vm))) {
                if vm.orgName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.animalDonation.animal_organization_detail.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 5)
                        }
                    }, label: {
                        Image("list_org")
                    })
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

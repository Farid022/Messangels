//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationContact: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @ObservedObject var vm: AnimalDonatiopnViewModel
    private let title = "Sélectionnez un contact à qui confier *votre animal *vos animaux"

    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "ANIMAUX", title: title, valid: .constant(!vm.contactName.isEmpty), destination: AnyView(AnimalDonationPic(vm: vm))) {
                if vm.contactName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent(title) {
                            SingleContactSelectionList(contactId: $vm.animalDonation.animal_contact_detail.toUnwrapped(defaultValue: 0), contactName: $vm.contactName)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    HStack {
                        FuneralCapsuleView(name: vm.contactName) {
                            vm.contactName.removeAll()
                            vm.animalDonation.animal_contact_detail = nil
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationContact: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Vêtements et accessoires", title: "Sélectionnez un contact à qui donner *cet article *ces articles", valid: .constant(!vm.contactName.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if vm.contactName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet article *ces articles") {
                            SingleContactSelectionList(contactId: $vm.clothDonation.clothing_contact_detail.toUnwrapped(defaultValue: 0), contactName: $vm.contactName)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    FuneralCapsuleView(name: vm.contactName) {
                        vm.contactName.removeAll()
                        vm.clothDonation.clothing_contact_detail = nil
                    }
                }
            }
            
        }
    }
}

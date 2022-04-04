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
    var title: String {
        return "Sélectionnez un contact à qui donner \(vm.clothDonation.single_clothing! ? "cet article" : "ces articles")"
    }
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 5.0, totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: title, valid: .constant(!vm.contactName.isEmpty), destination: AnyView(ClothsDonationPic(vm: vm))) {
                if vm.contactName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent(title) {
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

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationContact: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @ObservedObject var vm: ObjectDonationViewModel
    var title: String {
        return "Sélectionnez un contact à qui donner\(vm.objectDonation.single_object! ? "cet objet" : "ce groupe d’objets")"
    }
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 5.0, totalSteps: 7.0, menuTitle: "Objets", title: title, valid: .constant(!vm.contactName.isEmpty), destination: AnyView(ObjectsDonationPic(vm: vm))) {
                if vm.contactName.isEmpty {
                    ContactsListButton() {
                        navigationModel.presentContent(title) {
                            SingleContactSelectionList(contactId: $vm.objectDonation.object_contact_detail.toUnwrapped(defaultValue: 0), contactName: $vm.contactName)
                        }
                    }
                } else {
                    FuneralCapsuleView(name: vm.contactName) {
                        vm.contactName.removeAll()
                        vm.objectDonation.object_contact_detail = nil
                    }
                }
            }
            
        }
    }
}

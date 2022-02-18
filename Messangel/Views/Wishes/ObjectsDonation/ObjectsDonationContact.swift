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
    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Objets", title: "Sélectionnez un contact à qui donner *cet objet *ce groupe d’objets", valid: .constant(!vm.contactName.isEmpty), destination: AnyView(ObjectsDonationPic(vm: vm))) {
                if vm.contactName.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Sélectionnez un contact à qui donner *cet objet *ce groupe d’objets") {
                            SingleContactSelectionList(contactId: $vm.objectDonation.object_contact_detail.toUnwrapped(defaultValue: 0), contactName: $vm.contactName)
                        }
                    }, label: {
                        Image("list_contact")
                    })
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

//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ObjectsDonationName: View {
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Objets", title: "\(!vm.objectDonation.single_object ? "Indiquez le nom de ce groupe d’objet" : "Indiquez le nom de cet objet")", valid: .constant(!vm.objectDonation.object_name.isEmpty), destination: AnyView(ObjectsDonationPlaceSelection(vm: vm))) {
            TextField("Titre", text: $vm.objectDonation.object_name)
            .normalShadow()
        }
    }
}



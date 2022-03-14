//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ClothsDonationName: View {
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        FlowBaseView(stepNumber: 3.0, totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: "Indiquez un nom pour ces article\(vm.clothDonation.single_clothing ?? true ? "s" : "")", valid: .constant(!vm.clothDonation.clothing_name.isEmpty), destination: AnyView(ClothsDonationPlaceSelection(vm: vm))) {
            TextField("Titre", text: $vm.clothDonation.clothing_name)
            .normalShadow()
        }
    }
}



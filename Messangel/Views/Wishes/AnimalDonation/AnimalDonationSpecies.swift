//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AnimalDonationSpecies: View {
    @ObservedObject var vm: AnimalDonatiopnViewModel
    
    var body: some View {
        FlowBaseView(stepNumber: 4.0, totalSteps: 8.0, menuTitle: "ANIMAUX", title: "\(vm.animalDonation.animal_name) – Indiquez le nom de son espèce", valid: .constant(!vm.animalDonation.animal_name.isEmpty), destination: AnyView(AnimalDonationPic(vm: vm))) {
            TextField("Labrador, hamster", text: $vm.animalDonation.animal_species)
            .normalShadow()
        }
    }
}



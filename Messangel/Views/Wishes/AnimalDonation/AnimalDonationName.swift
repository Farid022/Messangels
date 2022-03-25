//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AnimalDonationName: View {
    @ObservedObject var vm: AnimalDonatiopnViewModel
    
    var destination: AnyView {
        if vm.animalDonation.single_animal! {
            return AnyView(AnimalDonationSpecies(vm: vm))
        } else {
            return AnyView(AnimalDonationPic(vm: vm))
        }
    }
    
    var body: some View {
        FlowBaseView(stepNumber: 3.0, totalSteps: 8.0, menuTitle: "ANIMAUX", title: "\(!(vm.animalDonation.single_animal ?? true) ? "Indiquez un nom pour votre groupe d’animaux" : "Indiquez le nom de votre animal")", valid: .constant(!vm.animalDonation.animal_name.isEmpty), destination: destination) {
            TextField("Nom de l’animal", text: $vm.animalDonation.animal_name)
            .normalShadow()
        }
    }
}



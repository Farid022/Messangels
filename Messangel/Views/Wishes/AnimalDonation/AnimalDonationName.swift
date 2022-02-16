//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AnimalDonationName: View {
    @ObservedObject var vm: AnimalDonatiopnViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "ANIMAUX", title: "\(!vm.animalDonation.single_animal! ? "Indiquez un nom pour votre groupe d’animaux" : "Indiquez le nom de votre animal")", valid: .constant(!vm.animalDonation.animal_name.isEmpty), destination: AnyView(AnimalDonationPlaceSelection(vm: vm))) {
            TextField("Titre", text: $vm.animalDonation.animal_name)
            .normalShadow()
        }
    }
}



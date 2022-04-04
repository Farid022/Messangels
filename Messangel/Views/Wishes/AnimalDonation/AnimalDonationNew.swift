//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AnimalDonationNew: View {
    @ObservedObject var vm: AnimalDonatiopnViewModel
    var body: some View {
        FuneralNewItemView(totalSteps: 8.0, menuTitle: "ANIMAUX", title: "Ajoutez vos premiers animaux", destination: AnyView(AnimalDonationCount(vm: vm)))

    }
}



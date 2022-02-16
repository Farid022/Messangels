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
        FuneralNewItemView(menuTitle: "ANIMAUX", title: "Ajoutez vos premiers animaux", destination: AnyView(AnimalDonationCount(vm: vm)))

    }
}



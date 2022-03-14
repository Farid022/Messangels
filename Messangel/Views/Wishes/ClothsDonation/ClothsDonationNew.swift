//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ClothsDonationNew: View {
    @StateObject private var vm = ClothDonationViewModel()
    var body: some View {
        FuneralNewItemView(totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: "Ajoutez vos premiers vêtements ou accessoires", destination: AnyView(ClothsDonationCount(vm: vm)))

    }
}



//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ClothsDonationNew: View {
    var body: some View {
        FuneralNewItemView(menuTitle: "Vêtements et accessoires", title: "Ajoutez vos premiers vêtements ou accessoires", destination: AnyView(ClothsDonationCount()))

    }
}



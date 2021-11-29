//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ClothsDonationName: View {
    @State private var donationName = ""
    var donationType: ClothsDonationType
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Vêtements et accessoires", title: "Indiquez un nom pour ces article\(donationType == .multiple ? "s" : "")", valid: .constant(!donationName.isEmpty), destination: AnyView(ClothsDonationPlaceSelection())) {
           TextField("Titre", text: $donationName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



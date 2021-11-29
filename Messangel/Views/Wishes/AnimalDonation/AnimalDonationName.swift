//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AnimalDonationName: View {
    @State private var donationName = ""
    var donationType: ClothsDonationType
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "ANIMAUX", title: "\(donationType == .multiple ? "Indiquez un nom pour votre groupe d’animaux" : "Indiquez le nom de votre animal")", valid: .constant(!donationName.isEmpty), destination: AnyView(AnimalDonationPlaceSelection())) {
           TextField("Titre", text: $donationName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ObjectsDonationName: View {
    @State private var donationName = ""
    var donationType: ClothsDonationType
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Objets", title: "\(donationType == .multiple ? "Indiquez le nom de ce groupe d’objet" : "Indiquez le nom de cet objet")", valid: .constant(!donationName.isEmpty), destination: AnyView(ObjectsDonationPlaceSelection())) {
           TextField("Titre", text: $donationName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct PracticalCodeName: View {
    @State private var codeName = ""
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Codes pratiques", title: "Entrez un nom pour votre code", valid: .constant(!codeName.isEmpty), destination: AnyView(PracticalCodeText())) {
           TextField("Ordinateur salon, Alarme maison…", text: $codeName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



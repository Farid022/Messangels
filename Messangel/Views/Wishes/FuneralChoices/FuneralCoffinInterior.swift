//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinInterior: View {
    @State private var selectedChoice = ""
    @State private var noteText = ""
    var choices = ["Coton", "Satin", "Velours"]
    var funeralType: FuneralType
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Choix funéraires", title: "Choisissez le matériau intérieur du cercueil", destination: AnyView(FuneralCoffinAccessory(funeralType: funeralType)))
    }
}

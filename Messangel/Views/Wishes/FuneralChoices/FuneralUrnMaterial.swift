//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnMaterial: View {
    @State private var selectedChoice = ""
    @State private var noteText = ""
    private var choices = ["Composite", "Céramique", "Albâtre"]
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Choix funéraires", title: "Choisissez le matériau de l’urne", destination: AnyView(FuneralUrnStyle()))
    }
}

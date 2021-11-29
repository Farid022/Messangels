//
//  FuneralCoffinShape.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinShape: View {
    @State private var selectedChoice = ""
    @State private var noteText = ""
    var choices = ["Parisien", "Lyonnais", "Tombeau"]
    var funeralType: FuneralType
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Choix funéraires", title: "Choisissez une forme de cercueil", destination: AnyView(FuneralCoffinInterior(funeralType: funeralType)))
    }
}

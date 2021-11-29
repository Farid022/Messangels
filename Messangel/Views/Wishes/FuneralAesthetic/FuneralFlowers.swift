//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralFlowers: View {
    @State private var selectedChoice = ""
    @State private var noteText = ""
    var choices = ["Lys", "Tulipes", "Roses"]
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Esthétique", title: "Avez-vous une préférence concernant les fleurs ? (Plusieurs choix possibles)", destination: AnyView(FuneralDecoration()))
    }
}

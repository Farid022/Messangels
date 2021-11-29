//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnStyle: View {
    @State private var selectedChoice = ""
    @State private var noteText = ""
    private var choices = ["Classique", "Moderne", "Original"]
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Choix funéraires", title: "Choisissez un style d’urne", destination: AnyView(FuneralAshPlace()))
    }
}

//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralFlowers: View {
    @State private var noteText = ""
    @StateObject private var vm = FueneralAstheticViewModel()
    
    var choices = [
        FuneralChoice(id: 1, name: "Lys", image: ""),
        FuneralChoice(id: 2, name: "Tulipes", image: ""),
        FuneralChoice(id: 3, name: "Roses", image: "")
    ]
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.asthetic.flower, menuTitle: "Esthétique", title: "Avez-vous une préférence concernant les fleurs ? (Plusieurs choix possibles)", destination: AnyView(FuneralDecoration(vm: vm)))
    }
}

//
//  FuneralCoffinShape.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinShape: View {
    @State private var noteText = ""
    var choices = [
        FuneralChoice(id: 1, name: "Parisien", image: ""),
        FuneralChoice(id: 2, name: "Lyonnais", image: ""),
        FuneralChoice(id: 3, name: "Tombeau", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 4.0, totalSteps: 12.0, noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.coffin_finish.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez une forme de cercueil", destination: AnyView(FuneralCoffinInterior(vm: vm)), vm: vm)
    }
}

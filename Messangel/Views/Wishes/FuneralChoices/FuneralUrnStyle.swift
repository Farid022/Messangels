//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnStyle: View {
    @State private var noteText = ""
    var choices = [
        FuneralChoice(id: 1, name: "Classique", image: ""),
        FuneralChoice(id: 2, name: "Moderne", image: ""),
        FuneralChoice(id: 3, name: "Original", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 9.0, totalSteps: 12.0, noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.urn_style.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez un style d’urne", destination: AnyView(FuneralAshPlace(vm: vm)), vm: vm)
            .onDidAppear {
                UserDefaults.standard.set(75.0, forKey: wishesPersonal.first!.name)
            }
    }
}

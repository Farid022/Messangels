//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnMaterial: View {
    @State private var noteText = ""
    var choices = [
        FuneralCoice(id: 1, name: "Composite", image: ""),
        FuneralCoice(id: 2, name: "Céramique", image: ""),
        FuneralCoice(id: 3, name: "Albâtre", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.urn_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez le matériau de l’urne", destination: AnyView(FuneralUrnStyle(vm: vm)))
    }
}

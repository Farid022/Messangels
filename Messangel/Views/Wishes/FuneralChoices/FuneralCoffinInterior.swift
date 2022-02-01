//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinInterior: View {
    @State private var noteText = ""
    var choices = [
        FuneralChoice(id: 1, name: "Coton", image: ""),
        FuneralChoice(id: 2, name: "Satin", image: ""),
        FuneralChoice(id: 3, name: "Velours", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.internal_material, menuTitle: "Choix funéraires", title: "Choisissez le matériau intérieur du cercueil", destination: AnyView(FuneralCoffinAccessory(vm: vm)))
    }
}

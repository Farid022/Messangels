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
        FuneralCoice(id: 1, name: "Coton", image: ""),
        FuneralCoice(id: 2, name: "Satin", image: ""),
        FuneralCoice(id: 3, name: "Velours", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.internal_material, menuTitle: "Choix funéraires", title: "Choisissez le matériau intérieur du cercueil", destination: AnyView(FuneralCoffinAccessory(vm: vm)))
    }
}

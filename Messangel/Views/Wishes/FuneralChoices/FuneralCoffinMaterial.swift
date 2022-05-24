//
//  FuneralCoffinMaterial.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinMaterial: View {
    var choices = [
        FuneralChoice(id: 1, name: "Chêne", image: ""),
        FuneralChoice(id: 2, name: "Sapin", image: ""),
        FuneralChoice(id: 3, name: "Pin", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 3.0, totalSteps: 12.0, noteText: $vm.funeral.coffin_material_note.bound, noteAttachmentIds: $vm.funeral.coffin_material_note_attachment, choices: choices, selectedChoice: $vm.funeral.coffin_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez un matériau pour le cercueil", destination: AnyView(FuneralCoffinShape(vm: vm)), vm: vm)
    }
}

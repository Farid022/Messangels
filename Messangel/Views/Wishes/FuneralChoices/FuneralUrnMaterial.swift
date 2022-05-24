//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnMaterial: View {
    var choices = [
        FuneralChoice(id: 1, name: "Composite", image: ""),
        FuneralChoice(id: 2, name: "Céramique", image: ""),
        FuneralChoice(id: 3, name: "Albâtre", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 8.0, totalSteps: 12.0, noteText: $vm.funeral.urn_material_note.bound, noteAttachmentIds: $vm.funeral.urn_material_note_attachment, choices: choices, selectedChoice: $vm.funeral.urn_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez le matériau de l’urne", destination: AnyView(FuneralUrnStyle(vm: vm)), vm: vm)
    }
}

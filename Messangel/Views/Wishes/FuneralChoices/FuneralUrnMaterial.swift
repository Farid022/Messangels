//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnMaterial: View {
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 8.0, totalSteps: 12.0, noteText: $vm.funeral.urn_material_note.bound, noteAttachmentIds: $vm.funeral.urn_material_note_attachment, oldAttachedFiles: $vm.funeral.urn_material_note_attachments, choices: vm.choices, selectedChoice: $vm.funeral.urn_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez le matériau de l’urne", destination: AnyView(FuneralUrnStyle(vm: vm)), vm: vm, loading: $vm.loading)
            .onDidAppear {
                vm.loading.toggle()
                vm.choices.removeAll()
                vm.getChoices("urn_material") { success in
                    vm.loading.toggle()
                }
            }
    }
}

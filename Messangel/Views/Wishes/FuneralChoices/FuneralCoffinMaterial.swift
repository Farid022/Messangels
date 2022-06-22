//
//  FuneralCoffinMaterial.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinMaterial: View {
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 3.0, totalSteps: 12.0, noteText: $vm.funeral.coffin_material_note.bound, noteAttachmentIds: $vm.funeral.coffin_material_note_attachment, oldAttachedFiles: $vm.funeral.coffin_material_note_attachments, choices: vm.choices, selectedChoice: $vm.funeral.coffin_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez un matériau pour le cercueil", destination: AnyView(FuneralCoffinShape(vm: vm)), vm: vm, loading: $vm.loading)
            .onDidAppear {
                vm.loading.toggle()
                vm.choices.removeAll()
                vm.getChoices("coffin_material") { success in
                    vm.loading.toggle()
                }
            }
    }
}

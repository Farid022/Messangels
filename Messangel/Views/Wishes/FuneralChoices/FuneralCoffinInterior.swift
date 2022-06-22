//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinInterior: View {
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 5.0, totalSteps: 12.0, noteText:$vm.funeral.internal_material_note.bound, noteAttachmentIds: $vm.funeral.internal_material_note_attachment, oldAttachedFiles: $vm.funeral.internal_material_note_attachments, choices: vm.choices, selectedChoice: $vm.funeral.internal_material.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez le matériau intérieur du cercueil", destination: AnyView(FuneralCoffinAccessory(vm: vm)), vm: vm, loading: $vm.loading)
            .onDidAppear {
                vm.loading.toggle()
                vm.choices.removeAll()
                vm.getChoices("coffin_internal_material") { success in
                    vm.loading.toggle()
                }
            }
    }
}

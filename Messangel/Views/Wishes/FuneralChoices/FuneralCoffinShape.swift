//
//  FuneralCoffinShape.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinShape: View {
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 4.0, totalSteps: 12.0, noteText: $vm.funeral.coffin_finish_note.bound, noteAttachmentIds: $vm.funeral.coffin_finish_note_attachment, oldAttachedFiles: $vm.funeral.coffin_finish_note_attachments, choices: vm.choices, selectedChoice: $vm.funeral.coffin_finish.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez une forme de cercueil", destination: AnyView(FuneralCoffinInterior(vm: vm)), vm: vm, loading: $vm.loading)
            .onDidAppear {
                vm.loading.toggle()
                vm.choices.removeAll()
                vm.getChoices("coffin_finish") { success in
                    vm.loading.toggle()
                }
            }
    }
}

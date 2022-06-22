//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralUrnStyle: View {
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FlowChoicesView(tab: 1, stepNumber: 9.0, totalSteps: 12.0, noteText: $vm.funeral.urn_style_note.bound, noteAttachmentIds: $vm.funeral.urn_style_note_attachment, oldAttachedFiles: $vm.funeral.urn_style_note_attachments, choices: vm.choices, selectedChoice: $vm.funeral.urn_style.toUnwrapped(defaultValue: 0), menuTitle: "Choix funéraires", title: "Choisissez un style d’urne", destination: AnyView(FuneralAshPlace(vm: vm)), vm: vm, loading: $vm.loading)
//            .onDidAppear {
//                UserDefaults.standard.set(75.0, forKey: wishesPersonal.first!.name)
//            }
            .onDidAppear {
                vm.loading.toggle()
                vm.choices.removeAll()
                vm.getChoices("urn_style") { success in
                    vm.loading.toggle()
                }
            }
    }
}

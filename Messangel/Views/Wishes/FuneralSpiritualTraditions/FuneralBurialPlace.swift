//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralBurialPlace: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FuneralSpritualityViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Indiquez le lieu d’inhumation (cimetière précis, caveau familial…)"
    
    var body: some View {
        FuneralNoteAttachCutomActionView(totalSteps: 2.0, showNote: $showNote, note: $vm.sprituality.ceremony_note, loading: $loading, attachements: $vm.attachements, noteAttachmentIds: $vm.sprituality.spritual_ceremony_note_attachment, menuTitle: "Spiritualité et traditions", title: title) {
            loading.toggle()
            if !vm.updateRecord {
                vm.createSprituality() { success in
                    if success {
                        WishesViewModel.setProgress(tab: 5) { completed in
                            loading.toggle()
                            if completed {
                                successAction(title, navModel: navModel)
                            }
                        }
                    }
                }
            } else {
                vm.update(id: vm.spritualities[0].id) { success in
                    loading.toggle()
                    if success {
                        successAction(title, navModel: navModel)
                    }
                }
            }
        }
    }
}

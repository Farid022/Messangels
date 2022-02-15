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
    private func successFunc() {
        navModel.pushContent("Indiquez si vous souhaitez emporter des objets ou accessoires") {
            FuneralDoneView()
        }
    }
    
    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.sprituality.ceremony_note, loading: $loading, menuTitle: "Spiritualité et traditions", title: title) {
            loading.toggle()
            if !vm.updateRecord {
                vm.createSprituality() { success in
                    loading.toggle()
                    if success {
                        successFunc()
                    }
                }
            } else {
                vm.update(id: vm.spritualities[0].id) { success in
                    loading.toggle()
                    if success {
                        successFunc()
                    }
                }
            }
        }
    }
}

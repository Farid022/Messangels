//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ExtraWishesDetails: View {
    @State private var showNote = false
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    @ObservedObject var vm: ExtraWishViewModel
    var title = "Exprimez-vous librement sur vos volontés"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.extraWish.express_yourself_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                if vm.updateRecord {
                    vm.update(id: vm.extraWishes[0].id) { success in
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                } else {
                    vm.create() { success in
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: wishesExtras.last!.name, title: title, valid: .constant(true)) {
                NoteView(showNote: $showNote, note: $vm.extraWish.express_yourself_note)
            }
        }
    }
}

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
    @StateObject private var vm = ExtraWishViewModel()
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
                vm.create() { success in
                    loading.toggle()
                    if success {
                        navModel.pushContent(title) {
                            FuneralDoneView()
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: wishesExtras.last!.name, title: title, valid: .constant(true)) {
                NoteView(showNote: $showNote, note: $vm.extraWish.express_yourself_note)
            }
        }
    }
}

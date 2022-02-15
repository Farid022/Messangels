//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

private let title = "Ajoutez des informations en cas d’organisation particulière (trajet long, transfert, plusieurs lieux de cérémonie…)"

struct FuneralPlaceSpecials: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FuneralLocationViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.location.special_ceremony_note.bound)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.create() { success in
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                } else {
                    vm.update(id: vm.locations[0].id) { success in
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: "Lieux", title: title, valid: .constant(true)) {
                NoteView(showNote:$showNote, note: $vm.location.special_ceremony_note.bound)
            }
        }
    }
}

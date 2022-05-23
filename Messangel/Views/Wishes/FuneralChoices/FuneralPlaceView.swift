//
//  FuneralPlaceView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralPlaceView: View {
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FeneralViewModel
   
    
    var body: some View {
        FuneralNoteView(tab: 1, stepNumber: 2.0, totalSteps: 12.0, showNote: $showNote, note: $vm.funeral.place_burial_note.bound, noteAttachmentIds: $vm.funeral.place_burial_note_attachment, menuTitle: "Choix funéraires", title: vm.funeral.burial_type == 1 ? "Vous pouvez indiquer le lieu d’inhumation (cimetière, caveau familial…)" : "Indiquez le lieu de crémation (nom d’un crématorium)", destination: AnyView(FuneralCoffinMaterial(vm: vm)), vm: vm)
    }
}

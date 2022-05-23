//
//  FuneralCoffinAccessory.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinAccessory: View {
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralNoteView(tab: 1, stepNumber: 6.0, totalSteps: 12.0, showNote: $showNote, note: $vm.funeral.handle_note.bound, noteAttachmentIds: $vm.funeral.handle_note_attachment, menuTitle: "Choix funéraires", title: "Précisez les accessoires obligatoires du cercueil (poignées, plaque d’identité,…)", destination: AnyView(FuneralCoffinOptions(vm: vm)), vm: vm)
    }
}

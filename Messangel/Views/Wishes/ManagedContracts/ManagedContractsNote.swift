//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct ManagedContractNote: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Contrats à gérer", title: "Ajoutez des informations ou documents utiles (numéros de contrat, photos de pièces justificatives…)", destination: AnyView(ManagedContractsList()))
    }
}

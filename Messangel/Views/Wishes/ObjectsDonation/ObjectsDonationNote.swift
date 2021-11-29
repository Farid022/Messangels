//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct ObjectsDonationNote: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Objets", title: "*NOMDELOBJET – Photo", destination: AnyView(ObjectsDonationsList()))
    }
}

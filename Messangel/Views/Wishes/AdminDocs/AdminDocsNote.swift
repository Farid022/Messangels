//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct AdminDocsNote: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Pièces administratives", title: "Joignez des scans ou photos des documents avec l’outil note", destination: AnyView(AdminDocsList()))
    }
}

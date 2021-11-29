//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicNote: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Musique", title: "Indiquez si vous avez des souhaits en particulier concernant ce titre (moments de diffusion, interprétation live…)", destination: AnyView(FuneralMusicList()))
    }
}

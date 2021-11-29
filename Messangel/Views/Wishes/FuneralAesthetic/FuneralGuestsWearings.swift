//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralGuestsWearings: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Esthétique", title: "Indiquez si vous souhaitez que les invités portent des accessoires en particulier", destination: AnyView(FuneralDoneView()))
    }
}

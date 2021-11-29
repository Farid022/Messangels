//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInviteText: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Annonces", title: "Indiquez si vous souhaitez intégrer des textes en particulier dans votre faire-part (citations, poèmes ou autres)", destination: AnyView(FuneralInviteNewsPaper()))
    }
}

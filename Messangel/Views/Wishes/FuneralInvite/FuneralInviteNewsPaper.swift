//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInviteNewsPaper: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Annonces", title: "Précisez un journal local dans lequel diffuser l’annonce", destination: AnyView(FuneralDoneView()))
    }
}

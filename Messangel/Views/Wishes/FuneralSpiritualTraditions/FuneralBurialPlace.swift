//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralBurialPlace: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Spiritualité et traditions", title: "Indiquez le lieu d’inhumation (cimetière précis, caveau familial…)", destination: AnyView(FuneralDoneView()))
    }
}

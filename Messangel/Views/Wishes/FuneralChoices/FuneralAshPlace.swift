//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralAshPlace: View {
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Choisissez un lieu de dépôt des cendres (columbarium, caveau, dispersion…)", destination: AnyView(FuneralOutfit()))
    }
}

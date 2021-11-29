//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralReunionPlace: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Lieux", title: "Vous pouvez apporter des précisions concernant le lieu des retrouvailles", destination: AnyView(FuneralPlaceSpecials()))
    }
}

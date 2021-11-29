//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralPlaceSpecials: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Lieux", title: "Ajoutez des informations en cas d’organisation particulière (trajet long, transfert, plusieurs lieux de cérémonie…)", destination: AnyView(FuneralDoneView()))
    }
}

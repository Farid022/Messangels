//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralDecoration: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Esthétique", title: "Indiquez si vous avez une demande particulière concernant la décoration", destination: AnyView(FuneralGuestsDress()))
    }
}

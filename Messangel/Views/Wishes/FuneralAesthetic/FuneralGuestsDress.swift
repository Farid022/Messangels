//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralGuestsDress: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Esthétique", title: "Indiquez vos souhaits concernant la tenue des invités", destination: AnyView(FuneralGuestsWearings()))
    }
}

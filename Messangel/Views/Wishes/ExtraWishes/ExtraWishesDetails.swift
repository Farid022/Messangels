//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ExtraWishesDetails: View {
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Expression libre", title: "Exprimez-vous librement sur vos volontés", destination: AnyView(FuneralDoneView()))
    }
}

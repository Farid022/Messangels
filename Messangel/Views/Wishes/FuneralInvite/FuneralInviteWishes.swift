//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInviteWishes: View {
    @State private var showNote = false
    @State private var note = ""
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Annonces", title: "Indiquez si vous avez des souhaits concernant l’apparence de votre faire part (thème visuel, symboles, format particulier ou autres)", destination: AnyView(FuneralInviteText()))
    }
}

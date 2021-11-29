//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinOptions: View {
    @State private var showNote = false
    @State private var note = ""
    var funeralType: FuneralType
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Précisez des options pour le cercueil (signe religieux, couleur,…)", destination: funeralType == .burial ? AnyView(FuneralOutfit()) : AnyView(FuneralUrnMaterial()))
    }
}

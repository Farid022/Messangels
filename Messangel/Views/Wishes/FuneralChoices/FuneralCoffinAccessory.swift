//
//  FuneralCoffinAccessory.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinAccessory: View {
    @State private var showNote = false
    @State private var note = ""
    var funeralType: FuneralType
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Précisez les accessoires obligatoires du cercueil (poignées, plaque d’identité,…)", destination: AnyView(FuneralCoffinOptions(funeralType: funeralType)))
    }
}

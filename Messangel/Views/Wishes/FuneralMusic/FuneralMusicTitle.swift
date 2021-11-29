//
//  FuneralMusicArtist.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicTitle: View {
    @State private var musicTitle = ""
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Musique", title: "Indiquez le nom du titre", valid: .constant(!musicTitle.isEmpty), destination: AnyView(FuneralMusicNote())) {
           TextField("Titre", text: $musicTitle)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



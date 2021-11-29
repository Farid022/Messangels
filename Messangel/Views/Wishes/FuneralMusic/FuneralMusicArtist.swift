//
//  FuneralMusicArtist.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicArtist: View {
    @State private var artist = ""
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Musique", title: "Indiquez le nom de l’artiste", valid: .constant(!artist.isEmpty), destination: AnyView(FuneralMusicTitle())) {
           TextField("Artiste", text: $artist)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



//
//  FuneralMusicArtist.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicTitle: View {
    @ObservedObject var vm: FuneralMusicViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Musique", title: "Indiquez le nom du titre", valid: .constant(!vm.music.song_title.isEmpty), destination: AnyView(FuneralMusicNote(vm: vm))) {
           TextField("Titre", text: $vm.music.song_title)
            .normalShadow()
        }
    }
}



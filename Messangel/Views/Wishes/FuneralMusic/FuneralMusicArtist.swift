//
//  FuneralMusicArtist.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicArtist: View {
    @StateObject private var vm = FuneralMusicViewModel()
    
    var body: some View {
        FlowBaseView(menuTitle: "Musique", title: "Indiquez le nom de l’artiste", valid: .constant(!vm.music.artist_name.isEmpty), destination: AnyView(FuneralMusicTitle(vm: vm))) {
           TextField("Artiste", text: $vm.music.artist_name)
            .normalShadow()
        }
    }
}



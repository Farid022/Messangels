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
        FlowBaseView(stepNumber: 3.0, totalSteps: 4.0, menuTitle: "Musique", title: "Indiquez le nom du titre", valid: .constant(!vm.music.song_title.isEmpty), destination: AnyView(FuneralMusicNote(vm: vm)), exitAction: {
            //
        }) {
           TextField("Titre", text: $vm.music.song_title)
            .normalShadow()
        }
    }
}



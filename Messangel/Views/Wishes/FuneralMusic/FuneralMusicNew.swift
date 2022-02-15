//
//  FuneralMusicNew.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicNew: View {
    @ObservedObject var vm: FuneralMusicViewModel
    var body: some View {
        FuneralNewItemView(menuTitle: "Musique", title: "Ajoutez un premier titre", destination: AnyView(FuneralMusicArtist(vm: vm)))
    }
}


struct FuneralNewItemView: View {
    var menuTitle: String
    var title: String
    var destination: AnyView
    
    var body: some View {
        FlowBaseView(addToList: true, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination) {
            EmptyView()
        }
    }
}


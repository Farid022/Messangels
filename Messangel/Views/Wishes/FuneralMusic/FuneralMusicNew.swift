//
//  FuneralMusicNew.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicNew: View {
    @StateObject private var vm = FuneralMusicViewModel()
    var body: some View {
        FuneralNewItemView(totalSteps: 4.0, menuTitle: "Musique", title: "Ajoutez un premier titre", destination: AnyView(FuneralMusicArtist(vm: vm)))
    }
}


struct FuneralNewItemView: View {
    var totalSteps: Double
    var menuTitle: String
    var title: String
    var destination: AnyView
    
    var body: some View {
        FlowBaseView(stepNumber: 1.0, totalSteps: totalSteps, addToList: true, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination) {
            EmptyView()
        }
    }
}


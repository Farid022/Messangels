//
//  FuneralCoffinShape.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinShape: View {
    @State private var noteText = ""
    var choices = [
        FuneralCoice(id: 1, name: "Parisien", image: ""),
        FuneralCoice(id: 2, name: "Lyonnais", image: ""),
        FuneralCoice(id: 3, name: "Tombeau", image: "")
    ]
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.coffin_finish, menuTitle: "Choix funéraires", title: "Choisissez une forme de cercueil", destination: AnyView(FuneralCoffinInterior(vm: vm)))
            .onDidAppear {
                UserDefaults.standard.set(25.0, forKey: wishesPersonal.first!.id)
            }
    }
}

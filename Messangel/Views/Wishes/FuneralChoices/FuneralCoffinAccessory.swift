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
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.funeral.handle_note, menuTitle: "Choix funéraires", title: "Précisez les accessoires obligatoires du cercueil (poignées, plaque d’identité,…)", destination: AnyView(FuneralCoffinOptions(vm: vm)))
    }
}

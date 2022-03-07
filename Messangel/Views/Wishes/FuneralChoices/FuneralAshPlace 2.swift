//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralAshPlace: View {
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FeneralViewModel
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.funeral.deposite_ashes_note, menuTitle: "Choix funéraires", title: "Choisissez un lieu de dépôt des cendres (columbarium, caveau, dispersion…)", destination: AnyView(FuneralOutfit(vm: vm)))
    }
}

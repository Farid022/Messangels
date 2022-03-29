//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinOptions: View {
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralNoteView(tab: 1, stepNumber: 7.0, totalSteps: 12.0, showNote: $showNote, note: $vm.funeral.religious_sign_note, menuTitle: "Choix funéraires", title: "Précisez des options pour le cercueil (signe religieux, couleur,…)", destination: vm.funeral.burial_type == FuneralType.burial.rawValue ? AnyView(FuneralOutfit(vm: vm)) : AnyView(FuneralUrnMaterial(vm: vm)), vm: vm)
    }
}

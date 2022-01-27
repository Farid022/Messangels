//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct ClothsDonationNote: View {
    @State private var showNote = false
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.clothDonation.clothing_note, menuTitle: "Vêtements et accessoires", title: "Ajoutez des informations complémentaires (exemples : vêtement fragile, cas particuliers)", destination: AnyView(ClothsDonationsList(vm: vm)))
    }
}

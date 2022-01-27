//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct ObjectsDonationNote: View {
    @State private var showNote = false
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.objectDonation.object_note, menuTitle: "Objets", title: "*NOMDELOBJET – Photo", destination: AnyView(ObjectsDonationsList(vm: vm)))
    }
}

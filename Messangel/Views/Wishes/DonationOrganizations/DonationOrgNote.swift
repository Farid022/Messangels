//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct DonationOrgNote: View {
    @State private var showNote = false
    @ObservedObject var vm: DonationOrgViewModel
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.donationOrg.donation_note, menuTitle: "Dons et collectes", title: "Ajoutez des informations (montants, collecte à la cérémonie)", destination: AnyView(DonationOrgsList(vm: vm)))
    }
}

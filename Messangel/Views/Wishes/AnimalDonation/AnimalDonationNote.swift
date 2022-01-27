//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct AnimalDonationNote: View {
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "ANIMAUX", title: "Ajoutez des informations pratiques sur *votre animal *vos animaux (alimentation, santé, fréquence de sortie, animaux nombreux)", destination: AnyView(AnimalDonationsList(vm: vm)))
    }
}

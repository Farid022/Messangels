//
//  FuneralOutfit.swift
//  Messangel
//
//  Created by Saad on 10/20/21.
//

import SwiftUI

struct FuneralOutfit: View {
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Indiquez si vous souhaitez porter une tenue en particulier", destination: AnyView(FuneralTakeWithObjects()))
    }
}

struct FuneralOutfit_Previews: PreviewProvider {
    static var previews: some View {
        FuneralOutfit()
    }
}

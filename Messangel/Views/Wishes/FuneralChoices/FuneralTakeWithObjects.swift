//
//  FuneralTakeWithObjects.swift
//  Messangel
//
//  Created by Saad on 10/20/21.
//

import SwiftUI

struct FuneralTakeWithObjects: View {
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Indiquez si vous souhaitez emporter des objets ou accessoires", destination: AnyView(FuneralDoneView()))
    }
}

struct FuneralTakeWithObjects_Previews: PreviewProvider {
    static var previews: some View {
        FuneralTakeWithObjects()
    }
}

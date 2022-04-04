//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralReunionPlace: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 5.0, totalSteps: 6.0, showNote: $showNote, note: $vm.location.reunion_location_note.bound, menuTitle: "Lieux", title: "Vous pouvez apporter des précisions concernant le lieu des retrouvailles", destination: AnyView(FuneralPlaceSpecials(vm: vm)), vm: vm)
    }
}

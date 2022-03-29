//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralConvoyRoute: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 4.0, totalSteps: 6.0, showNote: $showNote, note: $vm.location.route_convey_note.bound, menuTitle: "Lieux", title: "Vous pouvez apporter des précisions concernant le trajet du convoi (passage devant le domicile, un lieu symbolique…)", destination: AnyView(FuneralReunionPlace(vm: vm)), vm: vm)
    }
}

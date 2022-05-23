//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralDecoration: View {
    @State private var showNote = false
    @ObservedObject var vm: FueneralAstheticViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 2.0, totalSteps: 4.0, showNote: $showNote, note: $vm.asthetic.special_decoration_note, noteAttachmentIds: $vm.asthetic.special_decoration_note_attachment, menuTitle: "Esthétique", title: "Indiquez si vous avez une demande particulière concernant la décoration", destination: AnyView(FuneralGuestsDress(vm: vm)), vm: vm)
    }
}

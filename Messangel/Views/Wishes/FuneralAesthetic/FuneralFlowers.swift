//
//  FuneralCoffinInterior.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralFlowers: View {
    @ObservedObject var vm: FueneralAstheticViewModel
    
    var choices = [
        FuneralChoice(id: 1, name: "Lys", image: ""),
        FuneralChoice(id: 2, name: "Tulipes", image: ""),
        FuneralChoice(id: 3, name: "Roses", image: "")
    ]
    var body: some View {
        FlowMultipleChoicesView(stepNumber: 1.0, totalSteps: 4.0, noteText: $vm.asthetic.flower_note.bound, noteAttachmentIds: $vm.asthetic.flower_note_attachment, oldAttachedFiles: $vm.asthetic.flower_note_attachments, choices: choices, selectedChoice: $vm.asthetic.flower, menuTitle: "Esthétique", title: "Avez-vous une préférence concernant les fleurs ? (Plusieurs choix possibles)", destination: AnyView(FuneralDecoration(vm: vm)), vm: vm)
    }
}

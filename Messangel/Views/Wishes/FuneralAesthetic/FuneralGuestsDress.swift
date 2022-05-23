//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralGuestsDress: View {
    @State private var showNote = false
    @ObservedObject var vm: FueneralAstheticViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 3.0, totalSteps: 4.0, showNote: $showNote, note: $vm.asthetic.attendence_dress_note, noteAttachmentIds: $vm.asthetic.attendence_dress_note_attachment, menuTitle: "Esthétique", title: "Indiquez vos souhaits concernant la tenue des invités", destination: AnyView(FuneralGuestsWearings(vm: vm)), vm: vm)
    }
}

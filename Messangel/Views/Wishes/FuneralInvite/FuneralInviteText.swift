//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInviteText: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    var body: some View {
        FuneralNoteView(stepNumber: 3.0, totalSteps: 4.0, showNote: $showNote, note: $vm.announcement.invitation_note, noteAttachmentIds: $vm.announcement.invitation_note_attachment, menuTitle: "Annonces", title: "Indiquez si vous souhaitez intégrer des textes en particulier dans votre faire-part (citations, poèmes ou autres)", destination: AnyView(FuneralInviteNewsPaper(vm: vm)), vm: vm)
    }
}

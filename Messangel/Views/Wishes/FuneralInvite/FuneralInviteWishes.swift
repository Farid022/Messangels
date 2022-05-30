//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInviteWishes: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 2.0, totalSteps: 4.0, showNote: $showNote, note: $vm.announcement.theme_note, noteAttachmentIds: $vm.announcement.theme_note_attachment, oldAttachedFiles: $vm.announcement.theme_note_attachments, menuTitle: "Annonces", title: "Indiquez si vous avez des souhaits concernant l’apparence de votre faire part (thème visuel, symboles, format particulier ou autres)", destination: AnyView(FuneralInviteText(vm: vm)), vm: vm)
    }
}

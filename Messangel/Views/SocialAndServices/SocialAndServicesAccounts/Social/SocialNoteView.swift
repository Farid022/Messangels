//
//  SocialNoteView.swift
//  Messangel
//
//  Created by Saad on 12/22/21.
//

import SwiftUI

struct SocialNoteView: View {
    @State private var showNote = false
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        FuneralNoteView(stepNumber: 5.0, totalSteps: 5.0, showNote: $showNote, note: $vm.account.lastPostNote.bound, noteAttachmentIds: $vm.account.lastPostNoteAttachment, oldAttachedFiles: $vm.account.lastPostNoteAttachments, menuTitle: "Ajouter un réseau social", title: "Si vous souhaitez faire publier un dernier message, rédigez-le dans Note", destination: AnyView(SocialAccPicView(vm: vm)), vm: FeneralViewModel())
    }
}


//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormNoteView: View {
    @State private var progress = (100/7)*6.0
    @State private var valid = false
    @State private var showNote = false
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.guardian.guardian_note.bound, attachements: $vm.attachements, noteAttachmentIds: $vm.guardian.guardian_note_attachment)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            GuardianFormBaseView(title: "Message personnel (facultatif)" ,progress: $progress, valid: .constant(true), destination: AnyView(GuardianFormConfirmSendView(vm: vm))) {
                
                HStack{
                    Spacer()
                    NoteView(showNote: $showNote, note: $vm.guardian.guardian_note.bound)
                    Spacer()
                }
            }
        }
    }
}

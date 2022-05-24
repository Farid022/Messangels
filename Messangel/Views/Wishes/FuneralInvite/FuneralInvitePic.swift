//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralInvitePic: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var isShowImagePickerOptions = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.announcement.invitation_photo_note.bound, attachements: $vm.attachements, noteAttachmentIds: $vm.announcement.invitation_photo_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 1.0, totalSteps: 4.0, noteText: $vm.announcement.invitation_photo_note.bound, note: true, showNote: $showNote, menuTitle: "Annonces", title: "Vous pouvez si vous le souhaitez, faire apparaître une photo sur votre faire part", valid: .constant(true), destination: AnyView(FuneralInviteWishes(vm: vm))) {
                ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $vm.invitePhoto, remoteImage: vm.announcement.invitation_photo, imageSize: 128.0)
            }
            
        }
    }
}

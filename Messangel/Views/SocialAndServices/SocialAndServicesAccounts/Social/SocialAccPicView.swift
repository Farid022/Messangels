//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct SocialAccPicView: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.account.lastPostImageNote.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(noteText: $vm.account.lastPostImageNote.bound, note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: "INSTAGRAM – Sélectionnez une photo pour accompagner ce message", valid: .constant(true), destination: AnyView(SocialPostTimeView(vm: vm))) {
                ImageSelectionView(isShowPhotoLibrary: $isShowPhotoLibrary, localImage: vm.socialAccPic, remoteImage: vm.account.lastPostImage ?? "")
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.socialAccPic)
        }
    }
}

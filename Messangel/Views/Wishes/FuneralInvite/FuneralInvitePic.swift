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
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.announcement.invitation_photo_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(noteText: $vm.announcement.invitation_photo_note.bound, note: true, showNote: $showNote, menuTitle: "Annonces", title: "Vous pouvez si vous le souhaitez, faire apparaître une photo sur votre faire part", valid: .constant(true), destination: AnyView(FuneralInviteWishes(vm: vm))) {
                ImageSelectionView(isShowPhotoLibrary: $isShowPhotoLibrary, localImage: vm.invitePhoto, remoteImage: vm.announcement.invitation_photo)
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.invitePhoto)
        }
    }
}

struct ImageSelectionView: View {
    @Binding var isShowPhotoLibrary: Bool
    var localImage: UIImage
    var remoteImage: String
    
    var body: some View {
        Rectangle()
            .fill(Color.accentColor)
            .frame(width: 66, height: 66)
            .cornerRadius(30)
            .overlay(
                Button(action: {
                    isShowPhotoLibrary.toggle()
                }, label: {
                    ZStack {
                        if remoteImage.isEmpty && localImage.cgImage == nil {
                            Image("ic_camera")
                        }
                        Group{
                            if localImage.cgImage != nil {
                                Image(uiImage: localImage)
                                    .resizable()
                                    .scaledToFit()
                            } else if !remoteImage.isEmpty {
                                AsyncImage(url: URL(string: remoteImage)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Loader(tintColor: .white)
                                }
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
                })
            )
        if localImage.cgImage == nil {
            Text("Ajouter une photo")
                .underline()
        }
    }
}

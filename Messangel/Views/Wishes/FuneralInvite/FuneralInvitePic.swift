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
    @State private var note = ""
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Annonces", title: "Vous pouvez si vous le souhaitez, faire apparaître une photo sur votre faire part", valid: .constant(true), destination: AnyView(FuneralInviteWishes(vm: vm))) {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 66, height: 66)
                    .cornerRadius(30)
                    .overlay(
                        Button(action: {
                            isShowPhotoLibrary.toggle()
                        }, label: {
                            ZStack {
                                    Image("ic_camera")
                                
                                Image(uiImage: vm.invitePhoto)
                                    .resizable()
                                    .frame(width: 66, height: 66)
                            }
                        })
                    )
                if vm.invitePhoto.cgImage == nil {
                    Text("Ajouter une photo")
                        .underline()
                }
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.invitePhoto)
        }
    }
}

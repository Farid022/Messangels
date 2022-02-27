//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack

struct AudioImageView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var groupVM: GroupViewModel
    @ObservedObject var player: Player
    @ObservedObject var vm: AudioViewModel
    @State private var valid = true
    @State private var isShowImagePickerOptions = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var audioImage = UIImage()

    var fileUrl: URL
    
    var body: some View {
        NavigationStackView("AudioImageView") {
            MenuBaseView(height: 60, title: "Filtre") {
                ZStack {
                    if audioImage.cgImage != nil {
                        Image(uiImage: audioImage)
                            .resizable()
                            .frame(width: 252, height: screenSize.width / 1.15)
                    } else {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(width: 252, height: screenSize.width / 1.15)
                            .padding(.bottom, 30)
                        Image("audio_preview_waves")
                    }
                    AudioPlayerButton(player: self.player)
                }
                        Button(action: {
                            isShowImagePickerOptions.toggle()
                        }, label: {
                            VStack {
                                Rectangle()
                                    .fill(Color.accentColor)
                                    .frame(width: 66, height: 66)
                                    .cornerRadius(30)
                                    .overlay(Image("ic_camera"))
                                Text("Ajouter une photo de couverture")
                                    .underline()
                            }
                        })
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.accentColor.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .overlay(
                            Button(action: {
                                navigationModel.pushContent("AudioImageView") {
                                    AudioGroupView(fileUrl: fileUrl, audioImage: audioImage, player: player, vm: vm)
                                }
                            }) {
                                Image(systemName: "chevron.right").foregroundColor(Color.white)
                            }
                        )
                }
            }
            .ActionSheet(showImagePickerOptions: $isShowImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $audioImage, isShown: $showImagePicker, sourceType: sourceType)
            }
        }
    }
}



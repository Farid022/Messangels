//
//  PhotosSelectionView.swift
//  Messangel
//
//  Created by Saad on 5/31/21.
//

import SwiftUI
import NavigationStack
import Combine

struct PhotosSelectionView: View {
    @EnvironmentObject var viewModel: AlbumViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    @State var showGallery = false
    var group: MsgGroupDetail
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showGallery {
                CustomImagePicker()
            }
            else {
                NavigationStackView("PhotosSelectionView") {
                    MenuBaseView(title: "Photos pour le groupe") {
                        Text(viewModel.albumImages.count == 0 ? "0 Photo pour ce groupe" : "\(viewModel.albumImages.count) Photos dans cet album")
                            .fontWeight(.medium)
                        Spacer().frame(height: viewModel.albumImages.isEmpty ? 150 : 20)
                        Button(action: {
                            withAnimation {
                                self.viewModel.albumImages.removeAll()
                                showGallery.toggle()
                            }
                        }, label: {
                            VStack {
                                RoundedRectangle(cornerRadius: 30.0)
                                    .frame(width: 66, height: 66)
                                    .overlay(Image("ic_camera_plus"))
                                if viewModel.albumImages.isEmpty {
                                Text("Sélectionner des photos dans mon appareil")
                                    .foregroundColor(.black)
                                }
                            }
                        })
                        .padding(.bottom)
                        if !viewModel.albumImages.isEmpty{
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 3.0), count: 2), spacing: 3.0) {
                                ForEach(viewModel.albumImages, id: \.self) { i in
                                    Image(uiImage: i.image)
                                        .centerCropped()
                                        .frame(width: (UIScreen.main.bounds.width-15)/2, height: 250)
                                }
                            }
                            .padding(.horizontal, -10)
                        }
                    }
                }
                .padding(.top, -47)
            }
            if showGallery {
                BottomView(viewModel: viewModel, showGallery: $showGallery, group: group)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var viewModel: AlbumViewModel
    @Binding var showGallery: Bool
    @StateObject private var glrVM = GalleryViewModel()
    @State private var isPerformingTask = false
    var group: MsgGroupDetail
    
    private func uploadAndCreate() {
        Task {
            var totalSize = 0
            for album in viewModel.albumImages {
                let (uploadedImage, size) = await uploadImage(album.image, type: "gallery")
                glrVM.gallery.images.append(GImage(imageLink: uploadedImage, size: size))
                totalSize += size
            }
            glrVM.gallery.group = group.id
            glrVM.gallery.size = totalSize
            glrVM.create { _ in
                isPerformingTask.toggle()
                withAnimation() {
                    showGallery.toggle()
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Button(action: {
                    isPerformingTask.toggle()
                    if let gallery = group.galleries, gallery.isEmpty {
                        uploadAndCreate()
                    } else {
                        glrVM.gallery.group = group.id
                        glrVM.gallery.size = 0
                        glrVM.gallery.images = []
                        glrVM.create { success in
                            if success {
                                uploadAndCreate()
                            }
                        }
                    }
                }) {
                    Text("Valider")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .frame(width: UIScreen.main.bounds.width / 2)
                }
                .background(Color.accentColor)
                .clipShape(Capsule())
                .padding(.bottom)
                .disabled(self.viewModel.albumImages.count == 0)
                .hidden(isPerformingTask)
            }
            .frame(width: UIScreen.main.bounds.width, height: 120)
            .background(Color.white)
            if isPerformingTask {
                Color.white.opacity(0.7)
                    .ignoresSafeArea()
                Loader()
            }
        }
    }
}

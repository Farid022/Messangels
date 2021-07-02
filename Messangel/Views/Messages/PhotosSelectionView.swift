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
    @ObservedObject var viewModel: AlbumViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    @State var showGallery = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showGallery {
                CustomImagePicker(viewModel: viewModel)
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
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width-15)/2, height: 250)
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                            .padding(.horizontal, -10)
                        }
                    }
                }
                .padding(.top, -47)
            }
            if showGallery {
                BottomView(viewModel: viewModel, showGallery: $showGallery)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var viewModel: AlbumViewModel
    @Binding var showGallery: Bool
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                DispatchQueue.main.async {
                    withAnimation() {
                        showGallery.toggle()
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
            .disabled(self.viewModel.albumImages.count == 0 ? true : false)
        }
        .frame(width: UIScreen.main.bounds.width, height: 120)
        .background(Color.white)
    }
}

struct PhotosSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelectionView(viewModel: AlbumViewModel())
    }
}

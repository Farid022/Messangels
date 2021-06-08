//
//  PhotosSelectionView.swift
//  Messangel
//
//  Created by Saad on 5/31/21.
//

import SwiftUI
import NavigationStack

struct PhotosSelectionView: View {
    @State var selectedImages: [SelectedImages] = []
    @EnvironmentObject var navigationModel: NavigationModel
    @State var showGallery = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showGallery {
                CustomImagePicker(selectedImages: $selectedImages)
            }
            else {
                NavigationStackView("PhotosSelectionView") {
                    MenuBaseView(title: "Photos pour le groupe") {
                        Text(selectedImages.count == 0 ? "0 Photo pour ce groupe" : "\(selectedImages.count) Photos dans cet album")
                            .fontWeight(.medium)
                        Spacer().frame(height: selectedImages.isEmpty ? 150 : 20)
                        Button(action: {
                            withAnimation {
                                self.selectedImages.removeAll()
                                showGallery.toggle()
                            }
                        }, label: {
                            VStack {
                                RoundedRectangle(cornerRadius: 30.0)
                                    .frame(width: 66, height: 66)
                                    .overlay(Image("ic_camera_plus"))
                                if selectedImages.isEmpty {
                                Text("Sélectionner des photos dans mon appareil")
                                    .foregroundColor(.black)
                                }
                            }
                        })
                        .padding(.bottom)
                        if !selectedImages.isEmpty{
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 3.0), count: 2), spacing: 3.0) {
                                ForEach(selectedImages, id: \.self) { i in
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
                BottomView(selectedImages: $selectedImages, showGallery: $showGallery)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var selectedImages : [SelectedImages]
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
            .disabled(self.selectedImages.count == 0 ? true : false)
        }
        .frame(width: UIScreen.main.bounds.width, height: 120)
        .background(Color.white)
    }
}

struct PhotosSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelectionView()
    }
}

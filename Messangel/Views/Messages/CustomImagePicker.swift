//
//  CustomImagePicker.swift
//  Messangel
//
//  Created by Saad on 6/2/21.
//

import SwiftUI
//import NavigationStack
import Photos

struct CustomImagePicker : View {
//    @EnvironmentObject var navigationModel: NavigationModel
    @State private var gridImages: [ImageData] = []
    @State private var disabled = false
    @ObservedObject var viewModel: AlbumViewModel
    
    var body: some View {
        MenuBaseView(title: "Sélectionner des photos") {
            if !self.gridImages.isEmpty{
                HStack{
                    Text("Pellicule")
                        .fontWeight(.bold)
                    Spacer()
                }
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1.0), count: 3), spacing: 1.0) {
                    ForEach(self.gridImages,id: \.self) { i in
//                        ForEach(i,id: \.self){j in
                            ImageCard(imageData: i, viewModel: viewModel)
//                        }
                    }
                }
                .padding(.horizontal, -16)
            }
            else {
                if self.disabled{
                    Text("Enable Storage Access In Settings !!!")
                }
                if self.gridImages.count == 0 {
                   Loader()
                }
            }
            
        }
        .padding(.top, -47)
        .onAppear {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized{
                    fetchImagesFromGallery()
                    self.disabled = false
                }
                else {
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    
    private func fetchImagesFromGallery() {
        DispatchQueue.global(qos: .background).async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            let photos: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: fetchOptions)
            for i in 0..<photos.count{
                gridImages.append(ImageData(image: photos[i].getAssetThumbnail(size: CGSize(width: 150, height: 150)), selected: false, asset: photos[i]))
            }
        }
    }
    
//    private func fetchImagesFromGallery(){
//        let opt = PHFetchOptions()
//        opt.includeHiddenAssets = false
//
//        let req = PHAsset.fetchAssets(with: .image, options: .none)
//
//        DispatchQueue.global(qos: .background).async {
//            print("fetch started")
//            let options = PHImageRequestOptions()
//            options.isSynchronous = true
//
//            for i in stride(from: 0, to: req.count, by: 3){
//
//                var iteration : [ImageData] = []
//
//                for j in i..<i+3{
//
//                    if j < req.count{
//
//                        PHCachingImageManager.default().requestImage(for: req[j], targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options) { (image, _) in
//
//                            let data1 = ImageData(image: image!, selected: false, asset: req[j])
//
//                            iteration.append(data1)
//
//                        }
//                    }
//                }
//                self.gridImages.append(iteration)
//            }
//            print("fetch ended")
//        }
//    }
}

struct Loader : View {
    var body: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
    }
}

struct ImageCard : View {
    @State var imageData : ImageData
    @State private var loading = false
    @StateObject var viewModel = AlbumViewModel()
    var body: some View{
        ZStack{
            Image(uiImage: self.imageData.image)
                .resizable()
                .scaledToFill()
            if self.imageData.selected{
                ZStack{
                    Color.white.opacity(0.5)
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            if loading {
                Loader()
            }
        }
        .frame(width: (UIScreen.main.bounds.width/3) - 1, height: 125)
        .clipped()
        .contentShape(Rectangle())
        .onTapGesture {
            if !self.imageData.selected {
                self.imageData.selected = true
                // Extracting Orginal Size of Image from Asset
                loading = true
                DispatchQueue.global(qos: .background).async {
//                    imageData.asset.getOrginalImage { image in
////                        DispatchQueue.main.async {
//                        self.selectedImages.append(SelectedImages(id:imageData.asset.localIdentifier, image: image))
//                            loading = false
////                        }
//                    }
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    // You can give your own Image size by replacing .init() to CGSize....
                    PHCachingImageManager.default().requestImage(for: self.imageData.asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                        DispatchQueue.main.async {
                            self.viewModel.albumImages.append(AlbumImage(id:imageData.asset.localIdentifier, image: image!))
                            loading = false
                        }
                    }
                }
            }
            else {
                for i in 0..<self.viewModel.albumImages.count{
                    if self.viewModel.albumImages[i].id == self.imageData.asset.localIdentifier {
                        self.viewModel.albumImages.remove(at: i)
                        self.imageData.selected = false
                        return
                    }
                }
            }
        } // onTap
    }
}

struct ImageData: Hashable {
    var image : UIImage
    var selected : Bool
    var asset : PHAsset
}


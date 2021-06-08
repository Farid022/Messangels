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
    @State private var gridImages : [[ImageData]] = []
    @State private var disabled = false
    @Binding var selectedImages : [SelectedImages]
    
    var body: some View {
        MenuBaseView(title: "Sélectionner des photos") {
            if !self.gridImages.isEmpty{
                HStack{
                    Text("Pellicule")
                        .fontWeight(.bold)
                    Spacer()
                }
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1.0), count: 3), spacing: 1.0) {
                    ForEach(self.gridImages,id: \.self){i in
                        ForEach(i,id: \.self){j in
                            ImageCard(imageData: j, selectedImages: self.$selectedImages)
                        }
                    }
                }
                .padding(.horizontal, -16)
            }
            else {
                if self.disabled{
                    Text("Enable Storage Access In Settings !!!")
                }
                if self.gridImages.count == 0 {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
            
        }
        .padding(.top, -47)
        .onAppear {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized{
                    self.getAllImages()
                    self.disabled = false
                }
                else {
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    
    func getAllImages(){
        let opt = PHFetchOptions()
        opt.includeHiddenAssets = false
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            print("fetch started")
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            
            for i in stride(from: 0, to: req.count, by: 3){
                
                var iteration : [ImageData] = []
                
                for j in i..<i+3{
                    
                    if j < req.count{
                        
                        PHCachingImageManager.default().requestImage(for: req[j], targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options) { (image, _) in
                            
                            let data1 = ImageData(image: image!, selected: false, asset: req[j])
                            
                            iteration.append(data1)
                            
                        }
                    }
                }
                self.gridImages.append(iteration)
            }
            print("fetch ended")
        }
    }
}

struct ImageCard : View {
    @State var imageData : ImageData
    @Binding var selectedImages : [SelectedImages]
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
        }
        .frame(width: (UIScreen.main.bounds.width/3) - 1, height: 125)
        .clipped()
        .contentShape(Rectangle())
        .onTapGesture {
            if !self.imageData.selected {
                self.imageData.selected = true
                // Extracting Orginal Size of Image from Asset
                DispatchQueue.global(qos: .background).async {
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    // You can give your own Image size by replacing .init() to CGSize....
                    PHCachingImageManager.default().requestImage(for: self.imageData.asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                        DispatchQueue.main.async {
                            self.selectedImages.append(SelectedImages(asset: self.imageData.asset, image: image!))
                        }
                    }
                }
                
            }
            else {
                for i in 0..<self.selectedImages.count{
                    if self.selectedImages[i].asset == self.imageData.asset{
                        self.selectedImages.remove(at: i)
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

struct SelectedImages: Hashable{
    
    var asset : PHAsset
    var image : UIImage
}

//private func fetchAlbums() {
////    self.albums.removeAll()
//    let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
//    result.enumerateObjects({ (collection, _, _) in
//        if (collection.hasAssets()) {
////            self.albums.append(collection)
//        }
//    })
////    self.collectionView.reloadData()
//}
//
//private func fetchImagesFromGallery(collection: PHAssetCollection?) {
//    DispatchQueue.main.async {
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
//        if let collection = collection {
////            self.photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
//        } else {
////            self.photos = PHAsset.fetchAssets(with: fetchOptions)
//        }
////        self.collectionView.reloadData()
//    }
//}
//
//extension PHPhotoLibrary {
//    // MARK: - Public methods
//    static func checkAuthorizationStatus(completion: @escaping (_ status: Bool) -> Void) {
//        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
//            completion(true)
//        } else {
//            PHPhotoLibrary.requestAuthorization({ (newStatus) in
//                if newStatus == PHAuthorizationStatus.authorized {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            })
//        }
//    }
//}
//
//extension PHAssetCollection {
//    // MARK: - Public methods
//    func getCoverImgWithSize(_ size: CGSize) -> UIImage! {
//        let assets = PHAsset.fetchAssets(in: self, options: nil)
//        let asset = assets.firstObject
//        return asset?.getAssetThumbnail(size: size)
//    }
//    func hasAssets() -> Bool {
//        let assets = PHAsset.fetchAssets(in: self, options: nil)
//        return assets.count > 0
//    }
//}
//
//extension PHAsset {
//    // MARK: - Public methods
//    func getAssetThumbnail(size: CGSize) -> UIImage {
//        let manager = PHImageManager.default()
//        let option = PHImageRequestOptions()
//        var thumbnail = UIImage()
//        option.isSynchronous = true
//        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
//            thumbnail = result!
//        })
//        return thumbnail
//    }
//    func getOrginalImage(complition:@escaping (UIImage) -> Void) {
//        let manager = PHImageManager.default()
//        let option = PHImageRequestOptions()
//        var image = UIImage()
//        manager.requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: {(result, info)->Void in
//            image = result!
//            complition(image)
//        })
//    }
//    func getImageFromPHAsset() -> UIImage {
//        var image = UIImage()
//        let requestOptions = PHImageRequestOptions()
//        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
//        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
//        requestOptions.isSynchronous = true
//        if (self.mediaType == PHAssetMediaType.image) {
//            PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: requestOptions, resultHandler: { (pickedImage, info) in
//                image = pickedImage!
//            })
//        }
//        return image
//    }
//}


//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ClothsDonationPic: View {
    @State private var valid = false
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: ClothDonationViewModel

    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Vêtements et accessoires", title: "*NOMVETEMENT  – Photo", valid: .constant(true), destination: AnyView(ClothsDonationNote(vm: vm))) {
                ImageSelectionView(isShowPhotoLibrary: $isShowPhotoLibrary, localImage: vm.localPhoto, remoteImage: vm.clothDonation.clothing_photo)
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.localPhoto)
        }
    }
}

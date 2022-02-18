//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ObjectsDonationPic: View {
    @State private var valid = false
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: ObjectDonationViewModel

    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Objets", title: "*NOMDUGROUPE – Photo", valid: .constant(true), destination: AnyView(ObjectsDonationNote(vm: vm))) {
                ImageSelectionView(isShowPhotoLibrary: $isShowPhotoLibrary, localImage: vm.localPhoto, remoteImage: vm.objectDonation.object_photo)
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.localPhoto)
        }
    }
}

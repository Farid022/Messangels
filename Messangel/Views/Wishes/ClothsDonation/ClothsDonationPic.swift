//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ClothsDonationPic: View {
    @State private var valid = false
    @State private var isShowImagePickerOptions = false
    @ObservedObject var vm: ClothDonationViewModel

    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 6.0, totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: "\(vm.clothDonation.clothing_name) – Photo", valid: .constant(true), destination: AnyView(ClothsDonationNote(vm: vm))) {
                ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $vm.localPhoto, remoteImage: vm.clothDonation.clothing_photo ?? "", imageSize: 128.0)
            }
            
        }
    }
}

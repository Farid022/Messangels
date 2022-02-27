//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ObjectsDonationPic: View {
    @State private var valid = false
    @State private var isShowImagePickerOptions = false
    @ObservedObject var vm: ObjectDonationViewModel

    
    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "Objets", title: "\(vm.objectDonation.object_name) – Photo", valid: .constant(true), destination: AnyView(ObjectsDonationNote(vm: vm))) {
                ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $vm.localPhoto, remoteImage: vm.objectDonation.object_photo ?? "", imageSize: 128.0)
            }
            
        }
    }
}

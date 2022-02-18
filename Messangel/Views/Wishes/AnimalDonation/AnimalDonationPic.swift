//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationPic: View {
    @State private var valid = false
    @State private var isShowPhotoLibrary = false
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
            FlowBaseView(menuTitle: "ANIMAUX", title: "*NOMDELANIMAL – Photo", valid: .constant(true), destination: AnyView(AnimalDonationNote(vm: vm))) {
                ImageSelectionView(isShowPhotoLibrary: $isShowPhotoLibrary, localImage: vm.localPhoto, remoteImage: vm.animalDonation.animal_photo ?? "")
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $vm.localPhoto)
        }
    }
}

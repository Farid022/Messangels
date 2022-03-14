//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationPic: View {
    @State private var valid = false
    @State private var isShowImagePickerOptions = false
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 5.0, totalSteps: 8.0, menuTitle: "ANIMAUX", title: "\(vm.animalDonation.animal_name) – Photo", valid: .constant(true), destination: AnyView(AnimalDonationPlaceSelection(vm: vm))) {
                ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $vm.localPhoto, remoteImage: vm.animalDonation.animal_photo ?? "", imageSize: 128.0)
            }
        }
    }
}

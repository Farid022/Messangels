//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        FuneralItemList(id:"ClothsDonationsList", menuTitle: "Vêtements et accessoires", newItemView: AnyView(ClothsDonationName(vm: ClothDonationViewModel()))) {
            ForEach(vm.donations, id: \.self) { donation in
                FuneralItemCard(title: donation.clothing_name, icon: "ic_cloth")
                    .onTapGesture {
                        navigationModel.pushContent("ClothsDonationsList") {
                            ClothsDonationDetails(title: donation.clothing_name, note: donation.clothing_note)
                        }
                    }
            }
        }
        .onDidAppear {
            vm.getAll()
        }
    }
}



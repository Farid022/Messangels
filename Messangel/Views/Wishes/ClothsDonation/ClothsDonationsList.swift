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
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "Vêtements et accessoires", newItemView: AnyView(ClothsDonationCount(vm: ClothDonationViewModel()))) {
            ForEach(vm.donations, id: \.self) { donation in
                FuneralItemCard(title: donation.clothing_name, icon: "ic_cloth")
                    .onTapGesture {
                        if let attachments = donation.clothing_note_attachment {
                            vm.attachements = attachments
                        }
                        navigationModel.pushContent(String(describing: Self.self)) {
                            ClothsDonationDetails(vm: vm, donation: donation)
                        }
                    }
            }
        }
        .onDidAppear {
            if refresh {
                vm.getAll { _ in }
            }
        }
    }
}



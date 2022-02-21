//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: DonationOrgViewModel
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "Dons et collectes", newItemView: AnyView(DonationOrgsSelectionView(vm: DonationOrgViewModel()))) {
            ForEach(vm.donationOrgs, id: \.self) { item in
                FuneralItemCard(title: item.donation_organization.name, icon: "ic_org")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            DonationOrgDetails(vm: vm, org: item)
                        }
                    }
            }
        }
        .onDidAppear {
            if refresh {
                vm.getDonationOrgs { _ in }
            }
        }
    }
}



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
    
    var body: some View {
        FuneralItemList(id:"DonationOrgsList", menuTitle: "Dons et collectes") {
            ForEach(vm.donationOrgs, id: \.self) { item in
                FuneralItemCard(title: item.donation_organization.name, icon: "ic_org")
                    .onTapGesture {
                        navigationModel.pushContent("DonationOrgsList") {
                            DonationOrgDetails(title: item.donation_organization.name, note: item.donation_note)
                        }
                    }
            }
        }
        .onDidAppear {
            vm.getDonationOrgs()
        }
    }
}



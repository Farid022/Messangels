//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgsList: View {
    var funeralItems = ["Nom Organisme", "Nom Organisme"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"DonationOrgsList", menuTitle: "Dons et collectes") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_org")
                    .onTapGesture {
                        navigationModel.pushContent("DonationOrgsList") {
                            DonationOrgDetails(title: item)
                        }
                    }
            }
        }
    }
}



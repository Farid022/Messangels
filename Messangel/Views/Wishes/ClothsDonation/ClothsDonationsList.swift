//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationsList: View {
    var funeralItems = ["Pull bleu", "Vêtement"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"ClothsDonationsList", menuTitle: "Vêtements et accessoires") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_cloth")
                    .onTapGesture {
                        navigationModel.pushContent("ClothsDonationsList") {
                            ClothsDonationDetails(title: item)
                        }
                    }
            }
        }
    }
}



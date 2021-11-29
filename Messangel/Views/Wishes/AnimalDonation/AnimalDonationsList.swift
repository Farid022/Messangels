//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationsList: View {
    var funeralItems = ["Pull bleu", "Vêtement"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"ClothsDonationsList", menuTitle: "ANIMAUX") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_cloth")
                    .onTapGesture {
                        navigationModel.pushContent("ClothsDonationsList") {
                            AnimalDonationDetails(title: item)
                        }
                    }
            }
        }
    }
}



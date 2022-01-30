//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        FuneralItemList(id:"ClothsDonationsList", menuTitle: "ANIMAUX") {
            ForEach(vm.donations, id: \.self) { item in
                FuneralItemCard(title: item.animal_name, icon: "ic_cloth")
                    .onTapGesture {
                        navigationModel.pushContent("ClothsDonationsList") {
                            AnimalDonationDetails(title: item.animal_name, note: item.animal_note)
                        }
                    }
            }
        }
        .onDidAppear {
            vm.getAll()
        }
    }
}



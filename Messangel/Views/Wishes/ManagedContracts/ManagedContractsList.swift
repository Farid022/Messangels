//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractsList: View {
    var funeralItems = ["Banque", "*NOMDUCONTRAT"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"ManagedContractsList", menuTitle: "Contrats à gérer") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_contract")
                    .onTapGesture {
                        navigationModel.pushContent("ManagedContractsList") {
                            ManagedContractsDetails(title: item)
                        }
                    }
            }
        }
    }
}



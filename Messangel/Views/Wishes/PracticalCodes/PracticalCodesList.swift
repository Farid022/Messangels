//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodesList: View {
    var funeralItems = ["Digicodes appartement Paris", "*NOMDUCODE"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"PracticalCodesList", menuTitle: "Codes pratiques") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent("PracticalCodesList") {
                            PracticalCodeDetails(title: item)
                        }
                    }
            }
        }
    }
}



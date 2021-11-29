//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct AdminDocsList: View {
    var funeralItems = ["Pièce d’identité", "*NOMDELAPIECE"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"AdminDocsList", menuTitle: "Pièces administratives") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent("AdminDocsList") {
                            AdminDocsDetails(title: item)
                        }
                    }
            }
        }
    }
}



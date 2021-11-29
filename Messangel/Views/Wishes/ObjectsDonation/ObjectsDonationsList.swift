//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationsList: View {
    var funeralItems = ["Livres bureau", "Objet"]
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        FuneralItemList(id:"ObjectsDonationsList", menuTitle: "Objets") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_animal")
                    .onTapGesture {
                        navigationModel.pushContent("ObjectsDonationsList") {
                            ObjectsDonationDetails(title: item)
                        }
                    }
            }
        }
    }
}



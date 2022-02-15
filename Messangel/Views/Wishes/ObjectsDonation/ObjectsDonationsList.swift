//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        FuneralItemList(id:"ObjectsDonationsList", menuTitle: "Objets", newItemView: AnyView(ObjectsDonationName(vm: ObjectDonationViewModel()))) {
            ForEach(vm.donations, id: \.self) { item in
                FuneralItemCard(title: item.object_name, icon: "ic_animal")
                    .onTapGesture {
                        navigationModel.pushContent("ObjectsDonationsList") {
                            ObjectsDonationDetails(title: item.object_name, note: vm.objectDonation.object_note)
                        }
                    }
            }
        }
        .onDidAppear {
            vm.getAll()
        }
    }
}



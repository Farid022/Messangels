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
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "Objets", newItemView: AnyView(ObjectsDonationCount(vm: ObjectDonationViewModel()))) {
            ForEach(vm.donations, id: \.self) { item in
                FuneralItemCard(title: item.object_name, icon: "ic_object")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            ObjectsDonationDetails(vm: vm, donation: item)
                        }
                    }
            }
        }
        .onDidAppear {
            if refresh {
                vm.getAll { _ in }
            }
        }
    }
}



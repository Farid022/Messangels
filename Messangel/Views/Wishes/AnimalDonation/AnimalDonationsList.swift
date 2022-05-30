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
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "ANIMAUX", newItemView: AnyView(AnimalDonationCount(vm: AnimalDonatiopnViewModel()))) {
            ForEach(vm.donations, id: \.self) { item in
                FuneralItemCard(title: item.animal_name, icon: "ic_animal")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            AnimalDonationDetails(vm: vm, donation: item)
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



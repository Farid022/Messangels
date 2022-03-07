//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: ContractViewModel
    
    var body: some View {
        FuneralItemList(id:"ManagedContractsList", menuTitle: "Contrats à gérer") {
            ForEach(vm.contracts, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_contract")
                    .onTapGesture {
                        navigationModel.pushContent("ManagedContractsList") {
                            ManagedContractsDetails(title: item.name, note: item.note)
                        }
                    }
            }
        }
        .onAppear {
            vm.getAll()
        }
    }
}



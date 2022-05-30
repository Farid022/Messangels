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
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: ManagedContractsList.self), menuTitle: "Contrats à gérer", newItemView: AnyView(ManagedContractName(vm: ContractViewModel()))) {
            ForEach(vm.contracts, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_contract")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: ManagedContractsList.self)) {
                            ManagedContractsDetails(vm: vm, contract: item)
                        }
                    }
            }
        }
        .task {
            if refresh {
                vm.getAll { _ in }
            }
        }
    }
}



//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ManagedContractNew: View {
    @ObservedObject var vm: ContractViewModel
    var body: some View {
        FuneralNewItemView(menuTitle: "Contrats à gérer", title: "Ajoutez un premier contrat à résilier", destination: AnyView(ManagedContractName(vm: vm)))

    }
}



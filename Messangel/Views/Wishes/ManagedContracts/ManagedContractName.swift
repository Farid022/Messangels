//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ManagedContractName: View {
    @ObservedObject var vm: ContractViewModel
    var body: some View {
        FlowBaseView(menuTitle: "Contrats à gérer", title: "Entrez un nom pour ce contrat", valid: .constant(!vm.contract.contract_name.isEmpty), destination: AnyView(ManagedContractNote(vm: vm))) {
            TextField("Téléphone, Banque, Assurance, Mutuelle", text: $vm.contract.contract_name)
            .normalShadow()
        }
    }
}



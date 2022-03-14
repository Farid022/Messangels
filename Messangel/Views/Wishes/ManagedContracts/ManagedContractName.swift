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
        FlowBaseView(stepNumber: 2.0, totalSteps: 4.0, menuTitle: "Contrats à gérer", title: "Entrez un nom pour ce contrat", valid: .constant(!vm.contract.contract_name.isEmpty), destination: AnyView(ManagedContractOrganization(vm: vm))) {
            TextField("Téléphone, Banque, Assurance, Mutuelle", text: $vm.contract.contract_name)
            .normalShadow()
        }
    }
}



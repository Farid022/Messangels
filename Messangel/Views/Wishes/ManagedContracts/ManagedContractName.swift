//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ManagedContractName: View {
    @State private var contractName = ""
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Contrats à gérer", title: "Entrez un nom pour ce contrat", valid: .constant(!contractName.isEmpty), destination: AnyView(ManagedContractNew())) {
           TextField("Téléphone, Banque, Assurance, Mutuelle", text: $contractName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



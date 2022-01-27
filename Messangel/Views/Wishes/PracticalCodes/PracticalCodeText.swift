//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodeText: View {
    @State private var codeText = ""
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Codes pratiques", title: "Entrez votre code. Vous pouvez ajouter des codes complémentaires si nécessaires", valid: .constant(!codeText.isEmpty), destination: AnyView(PracticalCodesList())) {
           TextField("code", text: $codeText)
            .normalShadow()
        }
    }
}



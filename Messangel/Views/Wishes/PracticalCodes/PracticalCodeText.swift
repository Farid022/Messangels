//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct PracticalCodeText: View {
    @State private var codeText = ""
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Codes pratiques", title: "Entrez votre code. Vous pouvez ajouter des codes complémentaires si nécessaires", valid: .constant(!codeText.isEmpty), destination: AnyView(PracticalCodesList())) {
           TextField("code", text: $codeText)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



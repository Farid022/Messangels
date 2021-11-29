//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AdminDocsName: View {
    @State private var docName = ""
    
    var body: some View {
        FuneralChoiceBaseView(menuTitle: "Pièces administratives", title: "Entrez un nom pour votre pièce administrative. Consultez le guide pour plus d’informations sur les pièces recommandées", valid: .constant(!docName.isEmpty), destination: AnyView(AdminDocsNote())) {
           TextField("Pièce d’identité, livret de famille…", text: $docName)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
        }
    }
}



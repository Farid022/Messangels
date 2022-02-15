//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AdminDocsName: View {
    @ObservedObject var vm: AdminDocViewModel

    var body: some View {
        FlowBaseView(menuTitle: "Pièces administratives", title: "Entrez un nom pour votre pièce administrative. Consultez le guide pour plus d’informations sur les pièces recommandées", valid: .constant(!vm.adminDoc.document_name.isEmpty), destination: AnyView(AdminDocsNote(vm: vm))) {
            TextField("Pièce d’identité, livret de famille…", text: $vm.adminDoc.document_name)
            .normalShadow()
        }
    }
}



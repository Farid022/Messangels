//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct AdminDocsNew: View {
    @ObservedObject var vm: AdminDocViewModel

    var body: some View {
        FuneralNewItemView(totalSteps: 3.0, menuTitle: "Pièces administratives", title: "Ajoutez une pièce administrative", destination: AnyView(AdminDocsName(vm: vm)))

    }
}



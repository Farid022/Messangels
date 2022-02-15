//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct PracticalCodeName: View {
    @ObservedObject var vm: PracticalCodeViewModel
    var body: some View {
        FlowBaseView(menuTitle: "Codes pratiques", title: "Entrez un nom pour votre code", valid: .constant(!vm.practicalCode.name.isEmpty), destination: AnyView(PracticalCodeText(vm: vm))) {
            TextField("Ordinateur salon, Alarme maison…", text: $vm.practicalCode.name)
            .normalShadow()
        }
    }
}



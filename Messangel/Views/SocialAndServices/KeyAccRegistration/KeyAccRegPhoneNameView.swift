//
//  KeyAccRegPhoneNameView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI

struct KeyAccRegPhoneNameView: View {
    @ObservedObject var vm: KeyAccViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "Indiquez un nom pour votre smartphone", valid: .constant(!vm.keySmartPhone.name.isEmpty), destination: AnyView(KeyAccRegTelView(vm: vm))) {
            TextField("Exemple : iPhone de Jean", text: $vm.keySmartPhone.name)
                .normalShadow()
        }
    }
}



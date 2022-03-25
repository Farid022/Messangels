//
//  KeyAccRegTelView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI

struct KeyAccRegTelView: View {
    @ObservedObject var vm: KeyAccViewModel
    
    var body: some View {
        FlowBaseView(stepNumber: 5.0, totalSteps: 6.0, menuTitle: "Comptes-clés", title: "\(vm.keySmartPhone.name) - Saisissez le numéro de téléphone de votre smartphone", valid: .constant(!vm.keySmartPhone.phoneNum.isEmpty), destination: AnyView(KeyAccRegPhonePINView(vm: vm))) {
            TextField("Numéro de téléphone", text: $vm.keySmartPhone.phoneNum)
                .keyboardType(.phonePad)
                .normalShadow()
        }
    }
}


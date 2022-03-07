//
//  KeyAccRegPhonePINView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI

struct KeyAccRegPhonePINView: View {
    @ObservedObject var vm: KeyAccViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "\(vm.keySmartPhone.name) - Saisissez le code PIN votre smartphone", valid: .constant(!vm.keySmartPhone.pincode.isEmpty), destination: AnyView(KeyAccRegPhoneCodeView(vm: vm))) {
            TextField("Code PIN", text: $vm.keySmartPhone.pincode)
                .keyboardType(.numberPad)
                .normalShadow()
        }
    }
}

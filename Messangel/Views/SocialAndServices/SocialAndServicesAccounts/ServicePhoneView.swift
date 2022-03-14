//
//  ServicePhoneView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI

struct ServicePhoneView: View {
    @ObservedObject var vm: KeyAccViewModel
    @ObservedObject var serviceVM: OnlineServiceViewModel
    
    var body: some View {
        FlowBaseView(stepNumber: 4.0, totalSteps: 5.0, menuTitle: "Ajouter un réseau social ou un#service en ligne", title: "Sélectionnez le smartphone associé, le cas échant", valid: .constant(true), destination: serviceVM.service.type == "listing" ? AnyView(ServiceChoiceView(vm: serviceVM)) : AnyView(SocialChoiceView(vm: serviceVM))) {
            
            ForEach(vm.smartphones, id: \.self) { phone in
                PhoneCapsule(name: phone.name, selected: .constant(serviceVM.accountFields.smartphone == phone.id))
                    .onTapGesture {
                        serviceVM.accountFields.smartphone = phone.id ?? 0
                    }
            }
        }
        .onDidAppear {
            vm.getKeyPhones()
        }
    }
}

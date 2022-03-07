//
//  ServiceEmailView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI

struct ServiceEmailView: View {
    @StateObject private var vm = KeyAccViewModel()
    @ObservedObject var serviceVM: OnlineServiceViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Ajouter un réseau social ou un#service en ligne", title: "Sélectionnez le compte-clé associé", valid: .constant(true), destination: AnyView(ServicePhoneView(vm: vm, serviceVM: serviceVM))) {
            
            ForEach(vm.keyAccounts, id: \.self) { account in
                KeyAccountCapsule(email: account.email, selected: .constant(serviceVM.accountFields.mailAccount == account.id))
                    .onTapGesture {
                        serviceVM.accountFields.mailAccount = account.id ?? 0
                    }
            }
        }
        .onDidAppear {
            vm.getKeyAccounts { success in
                
            }
        }
    }
}

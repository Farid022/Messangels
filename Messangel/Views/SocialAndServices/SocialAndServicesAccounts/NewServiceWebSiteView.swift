//
//  NewServiceWebSiteView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct NewServiceWebSiteView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: OnlineServiceViewModel
    var title = "Indiquez un site web"
    var name: String
    var body: some View {
        FlowBaseView(stepNumber: 2.0, totalSteps: 5.0, isCustomAction: true, customAction: {
            vm.service.name = name
            vm.addService { success in
                if success {
                    navigationModel.pushContent(title) {
                        ServiceEmailView(serviceVM: vm)
                    }
                }
            }
        }, menuTitle: "Ajouter un réseau social ou un#service en ligne", title: title, valid: .constant(!vm.service.url.isEmpty)) {
            TextField("Site web", text: $vm.service.url)
                .normalShadow()
        }
    }
}

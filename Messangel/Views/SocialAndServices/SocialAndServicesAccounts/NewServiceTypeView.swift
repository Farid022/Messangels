//
//  ServiceChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct NewServiceTypeView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = OnlineServiceViewModel()
    
    private let title = "S'agit-il d'un service en ligne ou d'un réseau social ?"
    var name: String
    
    var body: some View {
        FlowBaseView(menuTitle: "Ajouter un service en ligne", title: title, valid: .constant(!vm.service.type.isEmpty), destination: AnyView(NewServiceWebSiteView(vm: vm, name: name))) {
            HStack {
                ForEach(["listing", "social"], id: \.self) { choice in
                    ChoiceCard(text: choice == "listing" ? "Service en ligne" : "Réseau social", selected: .constant(vm.service.type == choice))
                        .onTapGesture {
                            vm.service.type = choice
                        }
                }
            }
        }
    }
}

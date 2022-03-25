//
//  DDIsJudicialView.swift
//  Messangel
//
//  Created by Saad on 2/26/22.
//

import SwiftUI

struct DDIsJudicialView: View {
    @State private var progress = (100/3)*2.0
    @ObservedObject var vm: GuardianViewModel
    var body: some View {
        GuardianFormBaseView(title: "Le décès implique-t-il l’intervention d’une entité judiciaire ? (suicide, crime)" ,progress: $progress, valid: .constant(vm.death.legal != nil), destination: AnyView(DDStatementView(vm: vm))) {
            HStack {
                ForEach([false, true], id: \.self) { choice in
                    ChoiceCard(text: choice ? "Non" : "Oui", selected: .constant(vm.death.legal == choice))
                        .onTapGesture {
                            vm.death.legal = choice
                        }
                }
            }
        }
    }
}

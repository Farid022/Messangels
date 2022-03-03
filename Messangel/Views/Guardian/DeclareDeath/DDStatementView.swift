//
//  DDStatementView.swift
//  Messangel
//
//  Created by Saad on 2/26/22.
//

import SwiftUI

struct DDStatementView: View {
    @EnvironmentObject private var auth: Auth
    @State private var progress = (100/3)*3.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    
    var body: some View {
        GuardianFormBaseView(title: "Déclaration sur l’honneur" ,progress: $progress, valid: $valid, destination: AnyView(DDConfirmView(vm: vm))) {
            Text(statement)
                .padding(.bottom)
            Toggle(isOn: $valid, label: {
                Text("Je soussigné \(auth.user.last_name) \(auth.user.first_name), atteste sur l’honneur que les informations ci-dessus sont exactes.")
                    .font(.system(size: 13))
            })
            .toggleStyle(CheckboxToggleStyle())
        }
    }
}

fileprivate let statement = """
Moi, Sophie Carnero née le 6 juin à Paris,  déclare consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.

At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.

At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.

At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
"""

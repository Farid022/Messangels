//
//  DDUnderstandView.swift
//  Messangel
//
//  Created by Saad on 2/26/22.
//

import SwiftUI

struct DDUnderstandView: View {
    @State private var progress = 1.0
    @State private var valid = false
    @ObservedObject var vm: GuardianViewModel
    private let text = """
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.

At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
"""
    var body: some View {
        GuardianFormBaseView(title: "Avertissement" ,progress: $progress, valid: $valid, destination: AnyView(DDIsJudicialView(vm: vm))) {
            Text(text)
                .padding(.bottom, 30)
            Button("J’ai compris") {
                valid.toggle()
            }
            .buttonStyle(MyButtonStyle(padding: 0, foregroundColor: .white, backgroundColor: valid ? .accentColor : .gray))
            .normalShadow()
        }
    }
}

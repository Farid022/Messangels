//
//  GuardianFormLastNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormLastNameView: View {
    @State private var progress = 1.0
    @State private var valid = false
    @State private var lastName = ""
    
    var body: some View {
        GuardianFormBaseView(title: "Nom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormFirstNameView())) {
            TextField("Nom", text: $lastName, onCommit:  {
                valid = true
            })
            .shadow(color: .gray.opacity(0.3), radius: 10)
        }
    }
}

struct GuardianFormLastNameView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormLastNameView()
    }
}

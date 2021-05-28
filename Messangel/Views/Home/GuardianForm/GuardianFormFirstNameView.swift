//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormFirstNameView: View {
    @State private var progress = (100/7)*2.0
    @State private var valid = false
    @State private var firstName = ""
    
    var body: some View {
        GuardianFormBaseView(title: "Prénom de l’ange gardien" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormEmailView())) {
            TextField("Prénom", text: $firstName, onCommit:  {
                valid = true
            })
            .shadow(color: .gray.opacity(0.3), radius: 10)
        }
    }
}

struct GuardianFormFirstNameView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormFirstNameView()
    }
}

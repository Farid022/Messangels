//
//  SignupPostcodeView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupPostcodeView: View {
    @State private var postCode: String = ""
    @State private var progress = 12.5 * 2
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupGenderView()), currentView: "SignupPostcodeView", footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel").font(.system(size: 13)))) {
            Text("Indiquez votre code postal actuel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            TextField("", text: $postCode, onCommit:  {
                valid = true
            })
            .keyboardType(.numberPad)
            .textContentType(.postalCode)
        }
    }
}

struct SignupPostcodeView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPostcodeView()
    }
}

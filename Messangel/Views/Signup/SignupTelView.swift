//
//  SignupTelView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupTelView: View {
    @State private var tel: String = ""
    @State private var progress = 12.5 * 6
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupOTPView()), currentView: "SignupTelView", footer: AnyView(MyLink(url: "https://www.google.com", text: "Politique de confidentialité"))) {
                Text("Mon numéro de téléphone mobile")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Spacer().frame(height: 50)
                TextField("Numéro de téléphone", text: $tel, onCommit:  {
                    valid = true
                })
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
    }
}

struct SignupTelView_Previews: PreviewProvider {
    static var previews: some View {
        SignupTelView()
    }
}

//
//  SignupGenderView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupGenderView: View {
    @State private var male = true
    @State private var female = true
    @State private var other = true
    @State private var progress = 12.5 * 3
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupEmailView()), footer: AnyView(Text(""))) {
            Text("Je m’identifie comme…")
                .font(.title2)
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            Group {
                Button("Masculin", action: {
                    male = true
                    female = false
                    other = false
                    valid = true
                })
                .opacity(male ? 1 : 0.5)
                .accentColor(.black)
                Button("Féminin", action: {
                    male = false
                    female = true
                    other = false
                    valid = true
                })
                .opacity(female ? 1 : 0.5)
                .accentColor(.black)
                Button("Autre", action: {
                    male = false
                    female = false
                    other = true
                    valid = true
                })
                .opacity(other ? 1 : 0.5)
                .accentColor(.black)
            }.buttonStyle(MyButtonStyle(padding: 0))
        }
    }
}

struct SignupGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignupGenderView()
    }
}

//
//  SignupGenderView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct SignupGenderView: View {
    @State private var progress = 12.5 * 3
    @State private var valid = false
    @State private var editing = false
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupEmailView(userVM: userVM)), currentView: "SignupGenderView", footer: AnyView(Spacer())) {
            Text("Je m’identifie comme…")
                .font(.system(size: 22))
                .fontWeight(.bold)
//            Spacer().frame(height: 50)
            Group {
                Button("Masculin", action: {
                    userVM.user.gender = "1"
                    valid = true
                })
                .opacity(userVM.user.gender == "1" ? 1 : 0.5)
                .accentColor(.black)
                Button("Féminin", action: {
                    userVM.user.gender = "2"
                    valid = true
                })
                .opacity(userVM.user.gender == "2" ? 1 : 0.5)
                .accentColor(.black)
                Button("Autre", action: {
                    userVM.user.gender = "3"
                    valid = true
                })
                .opacity(userVM.user.gender == "3" ? 1 : 0.5)
                .accentColor(.black)
            }.buttonStyle(MyButtonStyle(padding: 0))
        }
        .onAppear() {
            valid = !userVM.user.gender.isEmpty
        }
    }
}

//struct SignupGenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupGenderView()
//    }
//}

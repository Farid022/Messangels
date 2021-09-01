//
//  SignupTelView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX

struct SignupTelView: View {
    @ObservedObject var userVM: UserViewModel
    @State private var progress = 12.5 * 6
    @State private var valid = false
    @State private var editing = true
    
    var body: some View {
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupOTPView(userVM: userVM)), currentView: "SignupTelView", footer: AnyView(MyLink(url: "https://www.google.com", text: "Politique de confidentialité"))) {
            Text("Mon numéro de téléphone mobile")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            CocoaTextField("Numéro de téléphone", text: $userVM.user.phone_number, onCommit:  {
                valid = true
            })
            .isFirstResponder(true)
            .keyboardType(.phonePad)
            .xTextFieldStyle()
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
        }
        .onChange(of: userVM.user.phone_number) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.phone_number.count == 10
    }
}

//struct SignupTelView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupTelView()
//    }
//}

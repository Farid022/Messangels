//
//  SignupPostcodeView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX

struct SignupPostcodeView: View {
    @State private var progress = 12.5 * 2
    @State private var valid = false
    @State private var editing = true
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupGenderView(userVM: userVM)), currentView: "SignupPostcodeView", footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel").font(.system(size: 13)))) {
            Text("Indiquez votre code postal actuel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            CocoaTextField("", text: $userVM.user.postal_code) { isEditing in
                self.editing = isEditing
            } onCommit:  {
            }
            .keyboardType(.numberPad)
            .textContentType(.postalCode)
            .isFirstResponder(true)
            .xTextFieldStyle()
        }
        .onChange(of: userVM.user.postal_code) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.postal_code.count == 5
    }
}

//struct SignupPostcodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupPostcodeView()
//    }
//}

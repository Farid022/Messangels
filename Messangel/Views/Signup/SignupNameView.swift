//
//  SignupNameView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUI
import NavigationStack

struct SignupNameView: View {
    enum Field {
        case firstName
        case lastName
    }
    
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var userVM = UserViewModel()
    @State private var referral = false
    @State private var progress = 1.0
    @State private var valid = false
    @FocusState private var focusedField: Field?
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupBirthView(userVM: userVM)), currentView: "SignupNameView", footer: AnyView(Text("Veuillez saisir votre vrai nom, sans utiliser\nde pseudonyme.").font(.system(size: 13)))) {
            Text("Je m'appelle")
                .font(.system(size: 22))
                .fontWeight(.bold)
            TextField("Prénom", text: $userVM.user.first_name)
                .focused($focusedField, equals: .firstName)
                .textContentType(.givenName)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .lastName
                }
            TextField("Nom", text: $userVM.user.last_name)
                .focused($focusedField, equals: .lastName)
                .textContentType(.familyName)
                .submitLabel(.next)
            Toggle(isOn: $referral) {
                Text("J’ai un code filleul")
                    .font(.system(size: 13))
            }
            .toggleStyle(CheckboxToggleStyle())
            if referral {
                TextField("Code filleul", text: $userVM.user.referral_code)
            }
        }
        .onDidAppear {
            focusedField = .firstName
        }
        .onChange(of: userVM.user.first_name) { value in
            self.validate()
        }
        .onChange(of: userVM.user.last_name) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = !userVM.user.first_name.isEmpty && !userVM.user.last_name.isEmpty
    }
}

//struct SignupNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupNameView()
//    }
//}

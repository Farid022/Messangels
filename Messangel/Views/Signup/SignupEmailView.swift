//
//  SignupEmailView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX
import NavigationStack
import Peppermint

struct SignupEmailView: View {
    @ObservedObject var userVM: UserViewModel
    @State private var progress = 12.5 * 4
    @State private var valid = false
    @State private var editing = true
    @State private var accept = false
    @State private var loading = false
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var error_msg = "Un compte avec cette email existe déjà"
    @State private var alert = false
    let predicate = EmailPredicate()
    
    var body: some View {
        SignupBaseView(isCustomAction: true, customAction: {
            loading = true
            APIService.shared.post(model: EmailVerify(email: userVM.user.email), response: userVM.apiResponse, endpoint: "users/email/exist", method: "PATCH") { result in
                DispatchQueue.main.async {
                    self.loading = false
                }
                switch result {
                case .success(let response):
                    if response.message == "New email" {
                        DispatchQueue.main.async {
                            navigationModel.pushContent("SignupEmailView") {
                                SignupPasswrdView(userVM: userVM)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.alert = true
                        }
                    }
                case .failure(let err):
                    print(err)
                    DispatchQueue.main.async {
                        self.alert = true
                    }
                }
            }
            
        },  progress: $progress, valid: $valid, destination: AnyView(SignupPasswrdView(userVM: userVM)), currentView: "SignupEmailView", footer: AnyView(Text(""))) {
            Text("Mon e-mail")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Un e-mail sera envoyé à cette adresse pour la confirmer.")
                .font(.system(size: 15))
            CocoaTextField("Mon adresse e-mail", text: $userVM.user.email)
//                .isFirstResponder(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .xTextFieldStyle()
            Toggle(isOn: $accept) {
                Text("J’accepte les conditions générales d’utilisation de mes données en conformité avec les normes européennes RGPD en vigueur. Lire")
                    .font(.system(size: 13))
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.trailing, -10)
            .onChange(of: accept) { value in
                self.validate()
            }
            if loading {
                HStack {
                    Spacer()
                    Loader(tintColor: .white)
                    Spacer()
                }
            }
        }
        .onChange(of: userVM.user.email) { value in
            self.validate()
        }
        .alert(isPresented:$alert) {
            Alert(
                title: Text("Un compte avec cette email existe déjà. Souhaitez-vous vous connecter?"),
                primaryButton: .default(Text("Se connecter")) {
                    navigationModel.pushContent("SignupEmailView") {
                        LoginView()
                    }
                },
                secondaryButton: .cancel(Text("Annuler"))
            )
        }
    }
    
    private func validate() {
        self.valid = predicate.evaluate(with: userVM.user.email) && self.accept
    }
}

//struct SignupEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupEmailView()
//    }
//}

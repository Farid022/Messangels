//
//  LoginView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI
import NavigationStack

struct ForgotPasswordView: View {
    @EnvironmentObject private var navModel: NavigationModel
    @StateObject private var auth = Auth()
    @State private var loading = false
    @State private var alert = false
    @State private var errorAlert = false
    
    var body: some View {
        NavigationStackView("ForgotPasswordView") {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        BackButton()
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 50)
                    Image("logo")
                    Text("Indiquez votre adresse mail pour réinitialiser votre mot de passe.")
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 50)
                    TextField("Adresse mail", text: $auth.credentials.email)
                        .keyboardType(.emailAddress)
                        .submitLabel(.go)
                        .onSubmit {
                            if auth.credentials.email.isEmpty { return }
                            loading.toggle()
                            auth.forgotPassword(auth.credentials.email) { success in
                                loading.toggle()
                                if success {
                                    alert.toggle()
                                } else {
                                    errorAlert.toggle()
                                }
                            }
                        }
                    if loading {
                        Loader(tintColor: .white)
                    }
                    Spacer()
                }
                .padding()
            }
            .textFieldStyle(MyTextFieldStyle())
            .foregroundColor(.white)
            .alert("Consultez vos mails", isPresented: $alert, actions: {
                Button("OK", role: .cancel) {
                    navModel.hideTopViewWithReverseAnimation()
                }
            }, message: {
                Text("Cliquez sur le lien que nous vous avons envoyé par mail pour réinitialiser votre mot de passe.")
            })
            .alert(auth.apiError.error, isPresented: $errorAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(auth.apiError.error_description)
            })
        }
    }
}

//
//  LoginView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI
import NavigationStack
import Peppermint

struct ForgotPasswordView: View {
    @EnvironmentObject private var navModel: NavigationModel
    @StateObject private var auth = Auth()
    @State private var loading = false
    @State private var alert = false
    @State private var errorAlert = false
    @FocusState private var isFocused: Bool
    let predicate = EmailPredicate()
    
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
                        .textInputAutocapitalization(.never)
                        .submitLabel(.send)
                        .focused($isFocused)
                        .onSubmit {
                            if !predicate.evaluate(with:auth.credentials.email) {
                                isFocused = true
                                return
                            }
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
            .alert("Désolé", isPresented: $errorAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(auth.apiError.error_description)
            })
        }
        .onDidAppear {
            isFocused = true
        }
    }
}

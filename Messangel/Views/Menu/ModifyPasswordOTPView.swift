//
//  KeyAccRegSMSView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct ModifyPasswordOTPView: View {
    @EnvironmentObject private var auth: Auth
    @EnvironmentObject private var navModel: NavigationModel
    @Binding var old_password: String
    @Binding var new_password: String
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State var code = ""
    @State var loading = false
    @State private var succesAlert = false
    @State private var failureAlert = false
    @StateObject var vm = SecureAccessViewModel()
    
    fileprivate func validateOTP() {
        vm.otp.otp = Int(code) ?? 0
        vm.authOTP {
            if vm.apiResponse.message == "1" {
                APIService.shared.post(model: Password(password: old_password, new_password: new_password), response: apiResponse, endpoint: "users/\(getUserId())/change-password", method: "PUT") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.apiResponse = response
                            succesAlert.toggle()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.apiError = error
                            failureAlert.toggle()
                        }
                    }
                }
            } else {
                loading.toggle()
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 7) {
                HStack {
                    BackButton()
                    Spacer()
                }
                Spacer()
                Image("ic_lock_white")
                Group {
                    Text("")
                        .hidden()
                    Text("Inscrivez le code reçu par SMS")
                        .padding(.bottom)
                }
                .font(.system(size: 17), weight: .bold)
                .foregroundColor(.white)
                OTPTextFieldView(code: $code)
                    .disabled(loading)
                    .onChange(of: code) { value in
                        if value.count == 4 {
                            loading.toggle()
                            validateOTP()
                        }
                    }
                if loading {
                    Loader(tintColor: .white)
                }
                Spacer()
            }
            .padding()
        }
        .foregroundColor(.white)
        .alert("Consultez vos mails et activez votre nouveau mot de passe", isPresented: $succesAlert, actions: {
            Button("OK", role: .cancel) {
                navModel.popContent(TabBarView.id)
            }
        }, message: {
            Text("Activez votre nouveau mot de passe en cliquant sur le lien que nous vous avons envoyé par mail.")
        })
        .alert(isPresented: $failureAlert, content: {
            Alert(title: Text(apiError.error), message: Text(apiError.error_description))
        })
        .onDidAppear {
            if code.isEmpty {
                APIService.shared.post(model: OTP(phone_number: auth.user.phone_number), response: apiResponse, endpoint: "users/otp", token: false) { result in
                    switch result {
                    case .success(let res):
                        DispatchQueue.main.async {
                            self.apiResponse = res
                        }
                    case .failure(let err):
                        print(err)
                    }
                }
            }
        }
    }
}



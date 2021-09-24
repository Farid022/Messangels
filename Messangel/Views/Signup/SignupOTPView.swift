//
//  SignupOTPView.swift
//  Messangel
//
//  Created by Saad on 5/9/21.
//

import SwiftUIX
import Combine
import NavigationStack

struct SignupOTPView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var progress = 12.5 * 7
    @State private var valid = false
    @State private var code: String = ""
    @State private var loading = false
    @State private var alert = false
    @State private var apiResponse = APIService.APIResponse(message: "")
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        NavigationStackView("SignupOTPView") {
            VStack {
                ZStack(alignment: .topLeading) {
                    Color.accentColor
                        .ignoresSafeArea()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            BackButton()
                            Spacer()
                            Image("logo_only")
                                .resizable()
                                .frame(width: 139.67, height: 35.1)
                            Spacer()
                        }
                        Spacer().frame(height: 15)
                        Text("Inscrivez le code reçu par SMS")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                        OTPTextFieldView(code: $code)
                        Loader(tintColor: .white)
                            .opacity(loading ? 1 : 0)
                        Spacer()
                        HStack {
                            Spacer()
                            Rectangle()
                                .frame(width: 56, height: 56)
                                .cornerRadius(25)
                                .opacity(valid ? 1 : 0.5)
                                .overlay(
                                    Button(action: {
                                        loading = true
                                        APIService.shared.post(model: OTPVerify(phone_number: userVM.user.phone_number, otp: code), response: apiResponse, endpoint: "users/otp/verify", token: false, method: "PATCH") { result in
                                            switch result {
                                            case .success(let resp):
                                                print(resp.message)
                                                if resp.message == "OTP Verified" {
                                                    APIService.shared.post(model: userVM.user, response: userVM.user, endpoint: "users/sign-up", token: false) { result in
                                                        loading = false
                                                        switch result {
                                                        case .success(let newuser):
                                                            print("User ID: \(newuser.id ?? 0)")
                                                            DispatchQueue.main.async {
                                                                navigationModel.pushContent("SignupOTPView") {
                                                                    SignupDoneView(userVM: userVM)
                                                                }
                                                            }
                                                        case .failure(let error):
                                                            print(error.error_description)
                                                        }
                                                    }
                                                } else {
                                                    DispatchQueue.main.async {
                                                        self.apiResponse = resp
                                                        alert.toggle()
                                                    }
                                                }
                                            case .failure(let err):
                                                print(err.error_description)
                                            }
                                        }
                                    }) {
                                        Image(systemName: "chevron.right").foregroundColor(.accentColor)
                                    }
                                )
                        }
                        .padding(.bottom)
                        SignupProgressView(progress: $progress)
                            .padding(.bottom, 1)
                    }.padding(.horizontal)
                }
                .foregroundColor(.white)
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text("Error"), message: Text(apiResponse.message))
        })
        .onChange(of: code) { value in
            valid = value.count == 4
        }
        .onDidAppear {
            if code.isEmpty {
                APIService.shared.post(model: OTP(phone_number: userVM.user.phone_number), response: apiResponse, endpoint: "users/otp", token: false) { result in
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

//struct SignupOTPView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupOTPView()
//    }
//}

//
//  SignupCodeView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX
import Combine
import NavigationStack

struct SignupCodeView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var progress = 12.5 * 7
    @State private var valid = false
    @State private var code: String = ""
    @State private var loading = false
    @State private var alert = false
    @State private var apiResponse = APIService.APIResponse(message: "")
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        SignupBaseView(isCustomAction: true, customAction: {
            loading = true
            APIService.shared.post(model: OTPVerify(phone_number: userVM.user.phone_number, otp: code), response: apiResponse, endpoint: "users/otp/verify", token: false, method: "PATCH") { result in
                switch result {
                case .success(let resp):
                    print(resp.message)
                    if resp.message == "OTP Verified" {
                        APIService.shared.post(model: userVM.user, response: userVM.user, endpoint: "users/sign-up", token: false) { result in
                            loading = false
                            switch result {
                            case .success(let newUser):
                                print("User ID: \(newUser.id ?? 0)")
                                DispatchQueue.main.async {
                                    navigationModel.pushContent("SignupCodeView") {
                                        SignupDoneView(user: newUser)
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
        }, progress: $progress, valid: $valid, destination: AnyView(SignupDoneView(user: userVM.user)), currentView: "SignupCodeView", footer: AnyView(EmptyView())) {
            
            Text("Inscrivez le code reçu par SMS")
                .font(.system(size: 22))
                .fontWeight(.bold)
            OTPTextFieldView(code: $code)
            HStack {
                Spacer()
                Loader(tintColor: .white)
                    .opacity(loading ? 1 : 0)
                Spacer()
            }
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


/////////////// /////////////////////

struct OTPTextFieldView: View {
    @Binding var code: String
    
    var body: some View {
        ZStack {
            CodeView
            CodeTextField
        }
    }
    
    private var CodeView: some View {
        return HStack(spacing: 20){
            Spacer()
            ForEach(0..<4){ index in
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.white)
                        .frame(width: 55,height: 55)
                    VStack {
                        if code.count > index {
                            Text("\(code[index].description)")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        } else {
                            Spacer().frame(height: 30)
                            Rectangle()
                                .fill(Color.gray.opacity(0.8))
                                .frame(width: 13, height: 3)
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    private var CodeTextField: some View {
        return CocoaTextField("", text: $code)
            .keyboardType(.numberPad)
            .isInitialFirstResponder(true)
            .foregroundColor(.clear)
            .textContentType(.oneTimeCode)
            .onReceive(Just(code)) { inputValue in
                if inputValue.count > 4 {
                    code.removeLast()
                }
            }
    }
}



//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//

import SwiftUIX
import Combine

struct ModifyMobileView: View {
    @EnvironmentObject var auth: Auth
    @State private var new_mobile = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    @State private var alert = false
    
    var body: some View {
        MenuBaseView(title: "Modifier téléphone mobile") {
            if !editing {
                AccessSecurityHeader()
            }
            HStack {
                VStack(spacing: 20) {
                    Text("Téléphone mobile actuel")
                        .font(.system(size: 17), weight: .bold)
                    Text(auth.user.phone_number.separate())
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .padding(.leading, -90)
                }
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("Nouveau téléphone mobile")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            CocoaTextField("Numéro de téléphone", text: $new_mobile) { isEditing in
                self.editing = isEditing
            }
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 30)
            
            Button(action: {
                if !valid {
                    return
                }
                APIService.shared.post(model: Mobile(email: auth.user.email, new_mobile: new_mobile.replacingOccurrences(of: " ", with: "")), response: apiResponse, endpoint: "users/\(getUserId())/change-phone", method: "PUT") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.apiResponse = response
                            if response.message == "password update sucesssfully" {
                                auth.user.phone_number = new_mobile
                                auth.updateUser()
                            }
                            alert.toggle()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error.error_description)
                            self.apiError = error
                            alert.toggle()
                        }
                    }
                }
            }, label: {
                Text("Modifier")
            })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
        }
        .textFieldStyle(MyTextFieldStyle())
        .onReceive(Just(new_mobile)) { inputValue in
            if inputValue.count > 14 {
                new_mobile.removeLast()
            }
        }
        .onChange(of: new_mobile) { value in
            new_mobile = value.applyPatternOnNumbers(pattern: "## ## ## ## ##", replacmentCharacter: "#")
            self.validate()
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiResponse.message.isEmpty ? apiError.error : "Confirmez votre demande"), message: Text(apiResponse.message.isEmpty ? apiError.error_description : "Confirmez votre demande de modification par mail."))
        })
    }
    
    private func validate() {
        self.valid = new_mobile.replacingOccurrences(of: " ", with: "") != auth.user.phone_number && new_mobile.count == 14
    }
}

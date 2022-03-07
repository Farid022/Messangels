//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//

import SwiftUIX
import Peppermint

struct ModifyEmailView: View {
    @EnvironmentObject var auth: Auth
    @State private var new_email = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    @State private var alert = false
    let predicate = EmailPredicate()
    
    var body: some View {
        MenuBaseView(title: "Modifier adresse mail") {
            if !editing {
                AccessSecurityHeader()
            }
            HStack {
                VStack(spacing: 20) {
                    Text("Adresse mail actuelle")
                        .font(.system(size: 17), weight: .bold)
                        .padding(.leading, -20)
                    Text(auth.user.email)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("Nouvelle adresse mail")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            CocoaTextField("Adresse mail", text: $new_email) { isEditing in
                self.editing = isEditing
            }
            .textContentType(.emailAddress)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 30)
            
            Button(action: {
                if !valid {
                    return
                }
                APIService.shared.post(model: Email(email: auth.user.email, new_email: new_email), response: apiResponse, endpoint: "users/\(getUserId())/change-email", method: "PUT") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.apiResponse = response
                            if response.message == "password update sucesssfully" {
                                auth.user.email = new_email
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
        .onChange(of: new_email) { value in
            self.validate()
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiResponse.message.isEmpty ? apiError.error : "Confirmez votre demande"), message: Text(apiResponse.message.isEmpty ? apiError.error_description : "Cliquez sur le lien que nous vous avons envoyé par mail pour confirmer votre changement d’adresse mail."))
        })
    }
    
    private func validate() {
        self.valid = new_email != auth.user.email && predicate.evaluate(with: new_email)
    }
}

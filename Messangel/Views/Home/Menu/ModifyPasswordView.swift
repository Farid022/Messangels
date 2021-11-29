//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//

import SwiftUIX

struct ModifyPasswordView: View {
    @EnvironmentObject var auth: Auth
    @State private var old_password = ""
    @State private var new_password = ""
    @State private var confirm_password = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    @State private var alert = false
    
    var body: some View {
        MenuBaseView(title: "Modifier mot de passe") {
            if !editing {
                AccessSecurityHeader()
            }
            HStack {
                Text("Mot de passe actuel")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            .padding(.bottom)
            CocoaTextField("Mot de passe actuel", text: $old_password) { isEditing in
                self.editing = isEditing
            }
            .secureTextEntry(true)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 30)
            HStack {
                Text("Nouveau mot de passe")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            CocoaTextField("Mot de passe", text: $new_password) { isEditing in
                self.editing = isEditing
            }
            .secureTextEntry(true)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 30)
            HStack {
                Text("Confirmer mot de passe")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            CocoaTextField("Nouveau mot de passe", text: $confirm_password) { isEditing in
                self.editing = isEditing
            }
            .secureTextEntry(true)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 50)
            Button(action: {
                if !valid {
                    return
                }
                APIService.shared.post(model: Password(password: old_password, new_password: new_password), response: apiResponse, endpoint: "users/\(auth.user.id ?? 0)/change-password", method: "PUT") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.apiResponse = response
                            if response.message == "password update sucesssfully" {
                                auth.user.password = new_password
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
        .onChange(of: new_password) { value in
            self.validate()
        }
        .onChange(of: confirm_password) { value in
            self.validate()
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiResponse.message.isEmpty ? apiError.error : "Modifier mot de passe"), message: Text(apiResponse.message.isEmpty ? apiError.error_description : "Vous pourrez utiliser votre nouveau mot de passe dès votre prochaine connexion."))
        })
    }
    
    private func validate() {
        self.valid = new_password.count >= 8 && new_password == confirm_password
    }
}

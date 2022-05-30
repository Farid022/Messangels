//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//

import SwiftUIX
import NavigationStack
import SwiftUI

struct ModifyPasswordView: View {
    @EnvironmentObject private var auth: Auth
    @EnvironmentObject private var navModel: NavigationModel
    @State private var old_password = ""
    @State private var new_password = ""
    @State private var confirm_password = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    @State private var alert = false
    @State private var hidePassword = true
    @State private var hideOldPassword = true
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(title: "Modifier mot de passe") {
                if !Keyboard.main.isShown {
                    PasswordModifyHeader()
                }
                HStack {
                    Text("Mot de passe actuel")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Spacer()
                }
                .padding(.bottom)
                MyTextField(placeholder: "Mot de passe actuel", text: $old_password, isSecureTextEntry: $hideOldPassword)
                    .xTextFieldStyle()
                    .normalShadow()
                    .overlay(HStack {
                        Spacer()
                        Image(systemName: hideOldPassword ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                            .animation(.default, value: hideOldPassword)
                            .onTapGesture {
                                hideOldPassword.toggle()
                            }
                    })
                    .padding(.bottom, 30)
                HStack {
                    Text("Nouveau mot de passe")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Spacer()
                }
                MyTextField(placeholder: "Mot de passe", text: $new_password, isSecureTextEntry: $hidePassword)
                    .xTextFieldStyle()
                    .overlay(HStack {
                        Spacer()
                        Image(systemName: hidePassword ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                            .animation(.default, value: hidePassword)
                            .onTapGesture {
                                hidePassword.toggle()
                            }
                    })
                    .normalShadow()
                    .padding(.bottom, 30)
                HStack {
                    Text("Confirmer mot de passe")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    Spacer()
                }
                MyTextField(placeholder: "Nouveau mot de passe", text: $confirm_password, isSecureTextEntry: $hidePassword) {
                    hideKeyboard()
                }
                    .xTextFieldStyle()
                    .overlay(HStack {
                        Spacer()
                        Image(systemName: hidePassword ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                            .animation(.default, value: hidePassword)
                            .onTapGesture {
                                hidePassword.toggle()
                            }
                    })
                    .normalShadow()
                HStack {
                    Text(new_password.count < 8 ? "Sécurité : Insuffisant" : "✓ Sécurité : Bon")
                        .font(.system(size: 13))
                        .padding(.leading)
                        .padding(.bottom, 50)
                    Spacer()
                }
                Button(action: {
                    if old_password.isEmpty || new_password.isEmpty || confirm_password.isEmpty {
                        self.apiError = APIService.APIErr(error: "Veuillez remplir tous les champs", error_description: "Tous les champs sont obligatoires pour modifier votre mot de passe")
                        alert.toggle()
                    }
                    else if new_password != confirm_password {
                        self.apiError = APIService.APIErr(error: "Confirmation de mot de passe incorrecte", error_description: "Veuillez confirmer votre nouveau mot de passe en saisissant un mot de passe identique.")
                        alert.toggle()
                    }
                    if !valid {
                        return
                    }
                    APIService.shared.post(model: Password(password: old_password, new_password: new_password), response: apiResponse, endpoint: "users/\(getUserId())/check-password", method: "PUT") { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                self.apiResponse = response
                                if response.message == "The current password is correct." {
                                    navModel.pushContent(String(describing: Self.self)) {
                                        ModifyPasswordOTPView(old_password: $old_password, new_password: $new_password)
                                    }
                                } else {
                                    alert.toggle()
                                }
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.apiError = error
                                alert.toggle()
                            }
                        }
                    }
                }, label: {
                    Text("Modifier")
                })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
                Spacer().frame(height: 100)
            }
            .textFieldStyle(MyTextFieldStyle())
            .onChange(of: new_password) { value in
                self.validate()
            }
            .onChange(of: confirm_password) { value in
                self.validate()
            }
            .alert(isPresented: $alert, content: {
                Alert(title: Text(errorTitle()), message: Text(errorMessage()))
            })
        }
    }
    
    private func validate() {
        self.valid = new_password.count >= 8 && new_password == confirm_password
    }
    
    private func errorTitle() -> String {
        switch apiError.error_description {
        case "The current password is incorrect, please enter it again.":
            return "Mot de passe actuel incorrect"
        case "Enter a new password different from your current password.":
            return "Nouveau mot de passe identique"
        default:
            return apiError.error
        }
    }
    
    private func errorMessage() -> String {
        switch apiError.error_description {
        case "The current password is incorrect, please enter it again.":
            return "Le mot de passe actuel est incorrect, veuillez le saisir à nouveau."
        case "Enter a new password different from your current password.":
            return "Saisissez un nouveau mot de passe différent de votre mot de passe actuel."
        default:
            return apiError.error_description
        }
    }
}


struct PasswordModifyHeader: View {
    var body: some View {
        Text("Votre mot de passe doit comporter 8 caractères minimum dont une majuscule et un chiffre. Ne le modifiez qu’en cas de nécessité.")
            .font(.system(size: 13))
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding()
    }
}

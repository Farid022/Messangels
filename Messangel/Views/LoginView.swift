//
//  LoginView.swift
//  Messengel
//
//  Created by Saad on 4/28/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject var auth = Auth()
    @EnvironmentObject var envAuth: Auth
    @EnvironmentObject var subVM: SubscriptionViewModel
    @State private var loading = false
    @State private var alert = false
    @State private var valid = false
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    BackButton()
                    Spacer()
                }
                Spacer()
                Image("logo")
                Text("Connectez-vous")
                    .padding(.bottom)
                TextField("Identifiant ou adresse mail", text: $auth.credentials.email)
                    .keyboardType(.emailAddress)
                SecureField("Mot de passe", text: $auth.credentials.password)
                HStack {
                    Spacer()
                    Text("Mot de passe oublié ?")
                        .font(.subheadline)
                        .underline()
                }
                Spacer()
                    .frame(height: 50)
                    .overlay(Group {
                        if loading {
                            Loader(tintColor: .white)
                        }
                    })
                Button("Connexion", action: {
                    withAnimation {
                        validate()
                        if !self.valid {
                            return
                        }
                        loading = true
                        APIService.shared.post(model: auth.credentials, response: auth.token, endpoint: "token", token: false) { result in
                            switch result {
                            case .success(let token):
                                DispatchQueue.main.async {
                                    auth.token = token
                                    UserDefaults.standard.set(token.access_token, forKey: "token")
                                    APIService.shared.post(model: auth.credentials, response: auth.user, endpoint: "users/sign-in") { result in
                                        switch result {
                                        case .success(let user):
                                            DispatchQueue.main.async {
                                                loading = false
                                                envAuth.user = user
                                                envAuth.user.password = auth.credentials.password
                                                envAuth.updateUser()
                                                subVM.checkSubscription()
                                            }
                                        case .failure(let err):
                                            print(err)
                                            DispatchQueue.main.async {
                                                loading = false
                                            }
                                        }
                                    }
                                }
                            case .failure(let err):
                                print(err.error_description)
                                DispatchQueue.main.async {
                                    loading = false
                                    apiError = err
                                    alert.toggle()
                                }
                            }
                        }
                    }
                })
                .buttonStyle(MyButtonStyle())
                .padding(.bottom, 50)
                FooterView()
            }
            .padding()
        }
        .textFieldStyle(MyTextFieldStyle())
        .foregroundColor(.white)
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiError.error), message: Text(apiError.error_description))
        })
        .onChange(of: auth.credentials.email) { value in
            self.validate()
        }
        .onChange(of: auth.credentials.password) { value in
            self.validate()
        }
        .onAppear() {
            self.valid = false
        }
    }
    
    func validate() {
        self.valid = !auth.credentials.email.isEmpty && !auth.credentials.password.isEmpty
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

struct FooterView: View {
    var body: some View {
        Link(destination: URL(string: "https://www.google.com")!, label: {
            Text("Politique de confidentialité")
                .underline()
        })
        Spacer()
    }
}

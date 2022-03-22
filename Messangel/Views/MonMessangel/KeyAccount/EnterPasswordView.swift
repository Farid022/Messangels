//
//  EnterPasswordView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import SwiftUI
import NavigationStack


struct EnterPasswordView: View {
    @StateObject private var KeyAccountVerficationViewModel = keyAccountVerficationViewModel()
    
    @EnvironmentObject private var navigationModel: NavigationModel
    @State var code: String = ""
    @State private var valid = true
    @State private var hidePassword = true
    static let id = String(describing: Self.self)
    
    var isEmail: Bool
    var emailDetail: PrimaryEmailAcc
    var phoneDetail: PrimaryPhone
    var body: some View {
        NavigationStackView("EnterPasswordView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Color.accentColor
                        .ignoresSafeArea()
                        
                    ScrollView {
                        Group
                        {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Group
                        {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                       HStack(alignment: .center)
                        {
                            
                            HStack(alignment:.center)
                            {
                            VStack(alignment: .center)
                            {
                                
                            Spacer()
                           
                            Image("ic_lock_white")
                                .frame(width: 21, height: 21)
                                .padding(.bottom,40)
                            Text("Accès sécurisé.")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                            Text("Entrez votre mot de passe Messangel ")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                            HStack(alignment: .center)
                            {
                                MyTextField(placeholder: "Mot de passe", text: $code, isSecureTextEntry: $hidePassword)
                                    .foregroundColor(.white)
                                    .frame(height:60)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .background(.white)
                                
                                 .cornerRadius(22)
                                    .padding(.horizontal,18)
                            }
                            
                            Spacer()
                            Text("Politique de confidentialité")
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
                                .padding(.top,100)
                            
                            Rectangle()
                                .frame(width: 200, height: 1, alignment: .center)
                                .padding(.top,-10)
                                .foregroundColor(.white)
                                
                                Spacer()
                               HStack
                                {
                                Spacer()
                                    
                                    
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(width: 56, height: 56)
                                        .cornerRadius(25)
                                        .padding(.trailing,18)
                                        .padding(.top,100)
                                        .opacity(1)
                                        .overlay(
                                            Button(action: {
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                
                                                
                                                self.KeyAccountVerficationViewModel.verifyPassword(password: code) { success in
                                                    if success
                                                    {  navigationModel.pushContent("EnterPasswordView") {
                                                        EnterOTPView(isEmail: isEmail, emailDetail: emailDetail, phoneDetail: phoneDetail)
                                                        }
                                                       
                                                    }
                                                    else
                                                    {
                                                    
                                                    }
                                                }

                                            }) {
                                                Image(systemName: "chevron.right").foregroundColor(Color.accentColor)
                                            }
                                        )
                              //   NextButton(source: EnterPasswordView.id, destination: AnyView(EnterOTPView()), active: $valid)
                                       
                                
                                }
                                
                            
                        }
                            }
                        }
                    }
                }
                
            }
        }
        .onAppear {
            
           
            
        }
        }
    }
}

struct EnterPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPasswordView(isEmail: false, emailDetail: PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: false), phoneDetail: PrimaryPhone(id: 0, name: "", phoneNum: "", pincode: "", deviceUnlockCode: ""))
    }
}

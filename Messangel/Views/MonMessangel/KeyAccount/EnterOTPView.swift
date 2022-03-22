//
//  EnterOTPView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import SwiftUI
import NavigationStack

struct EnterOTPView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var KeyAccountVerficationViewModel = keyAccountVerficationViewModel()
    @State var code1: String = ""
    @State var code2: String = ""
    @State var code3: String = ""
    @State var code4: String = ""
    
    @State private var valid = true
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
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
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
                        VStack
                        {
                            Spacer()
                           
                            Image("ic_lock_white")
                                .frame(width: 21, height: 21)
                                .padding(.bottom,40)
                            
                            Text("Inscrivez le code reçu par SMS")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                                .padding(.bottom,25)
                           
                            HStack(alignment: .center)
                            {
                                
                                TextField( text: $code1)
                                    .background(.white)
                                    .cornerRadius(22)
                                    .frame(width:56, height:56)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .background(.white)
                                
                                 .cornerRadius(22)
                                    .padding(.horizontal,16)
                                TextField( text: $code2)
                                    .background(.white)
                                    .cornerRadius(22)
                                    .frame(width:56, height:56)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .background(.white)
                                
                                 .cornerRadius(22)
                                    .padding(.horizontal,16)
                                
                                TextField( text: $code3)
                                    .background(.white)
                                    .cornerRadius(22)
                                    .frame(width:56, height:56)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .background(.white)
                                
                                 .cornerRadius(22)
                                    .padding(.horizontal,16)
                        
                                TextField( text: $code4)
                                    .background(.white)
                                    .cornerRadius(22)
                                    .frame(width:56, height:56)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .background(.white)
                                
                                 .cornerRadius(22)
                                    .padding(.horizontal,16)
                        
                        
                            }
                            .padding(.horizontal,36)
                            
                            Text("Provient de message")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
                                .padding(.bottom,0)
                                .padding(.top,25)
                            
                            Text("0000")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
                            
                            Rectangle()
                                .frame(width: 56, height: 1, alignment: .center)
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
                                    .padding(.trailing,18)
                                    .padding(.top,100)
                                    .overlay(
                                        Button(action: {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            
                                            
                                            self.KeyAccountVerficationViewModel.verifyOTP(otp: code1+code2+code3+code4) { success in
                                                if success
                                                {
                                                    if isEmail
                                                    {
                                                        navigationModel.pushContent("EnterPasswordView") {
                                                           KeyAccountEmailView(isVisible: true,emailDetail: emailDetail)
                                                        }
                                                    }
                                                    else
                                                    {
                                                        navigationModel.pushContent("EnterPasswordView") {
                                                           KeyAccountPhoneView(isVisible: true,phoneDetail: phoneDetail)
                                                        }
                                                    }
                                                   
                                                }
                                                else
                                                {
                                                
                                                }
                                            }
                                          
//                                                if active && isCustomAction {
//                                                    customAction()
//                                                } else if active {
//                                                    navigationModel.pushContent() {
//                                                        destination
//
//                                                    }
//                                                }
                                        }) {
                                            Image(systemName: "chevron.right").foregroundColor(Color.accentColor)
                                        }
                                    )
                                
                                
                              //  NextButton(source: EnterPasswordView.id, destination: AnyView(EnterOTPView()), active: $valid)
                                   
                            
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

struct EnterOTPView_Previews: PreviewProvider {
    static var previews: some View {
        EnterOTPView(isEmail: true, emailDetail: PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: false), phoneDetail: PrimaryPhone(id: 0, name: "", phoneNum: "", pincode: "", deviceUnlockCode: ""))
    }
}

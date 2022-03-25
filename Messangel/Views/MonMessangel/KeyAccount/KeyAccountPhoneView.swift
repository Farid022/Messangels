//
//  KeyAccountPhoneView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/16/22.
//

import SwiftUI
import NavigationStack

struct KeyAccountPhoneView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var isVisible: Bool
    @State var password: String = "1234"
    @State var code: String = "123456"
    @State private var hidePassword = true
    var phoneDetail : PrimaryPhone
    var body: some View {
        NavigationStackView("KeyAccountPhoneView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text(phoneDetail.name)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                        VStack(alignment:.leading){
                           
                            Text(phoneDetail.name)
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            
                            Text("Accès")
                                   .font(.system(size: 17))
                                   .fontWeight(.bold)
                                   .padding(.leading,24)
                                   .padding(.top,10)
                                   .padding(.bottom,24)
                            
                                   
                         
                         
                            HStack
                            {
                                Image("ic_key_color_native")
                                    .frame(width:26,height:13)
                            
                                Text("Associé à 0 compte")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("lockColor")
                                    .frame(width:26,height:13)
                            
                               HStack
                                {
                              
                                    if isVisible
                                    {
                                        TextField("", text: $password)
                                                .font(.system(size: 15))
                                                .disabled(true)
                                                .frame(width:40)
                                    }
                                    else
                                    {
                                        SecureField("", text: $password)
                                                .font(.system(size: 15))
                                                .disabled(true)
                                                .frame(width:40)
                                    }
                                        
                                SecureField("", text: $password)
                                        .font(.system(size: 15))
                                        .disabled(true)
                                        .frame(width:40)
                                    
                                        
                                
                                    
                                Text("(PIN)")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .padding(.leading,-8)
                                    
                                Spacer()
                                       
                                      
                                       
                                    
                                }
                                .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            HStack
                            {
                                Image("lockColor")
                                    .frame(width:26,height:13)
                            
                               HStack
                                {
                              
                                SecureField("", text: $code)
                                        .font(.system(size: 15))
                                        .disabled(true)
                                        .frame(width:60)
                                    
                                        
                                
                                    
                                Text("(Code de dévérouillage)")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .padding(.leading,-8)
                                    
                                Spacer()
                                       
                                      
                                       
                                    
                                }
                                .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,44)
                            
                            HStack(alignment:.center)
                            {
                                
                                Spacer()
                                HStack()
                                {
                                    Image("showPassword")
                                    .frame(width:21.5,height:15.5)
                                    .foregroundColor(.white)
                                    
                                    Text("Afficher")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .foregroundColor(Color.white)
                                       .padding(.leading,10)
                               
                                }
                                .frame(width: 133.5, height: 56)
                                .background(Color.accentColor)
                                .cornerRadius(22)
                                
                                Spacer()
                            }
                            .frame(width:.infinity)
                            .onTapGesture {
                                navigationModel.pushContent("KeyAccountPhoneView") {
                                    
                                    EnterPasswordView(isEmail: false, emailDetail: PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: false), phoneDetail: phoneDetail)
                                }
                            }
                           
                           
                            Text("Numéro")
                                   .font(.system(size: 17))
                                   .fontWeight(.bold)
                                   .padding(.leading,24)
                                   .padding(.top,40)
                                   .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("phoneNumberIcon")
                                    .frame(width:26,height:13)
                            
                                Text(phoneDetail.phoneNum)
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            
           
            code = phoneDetail.deviceUnlockCode
            password = phoneDetail.pincode
        }
        }
    }
}

struct KeyAccountPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        KeyAccountPhoneView(isVisible: false, phoneDetail: PrimaryPhone(id: 0, name: "", phoneNum: "", pincode: "", deviceUnlockCode: ""))
    }
}

//
//  KeyAccountEmailView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/16/22.
//

import SwiftUI
import NavigationStack

struct KeyAccountEmailView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var viewModel = keyAccountVerficationViewModel()
    var isVisible: Bool
    @State var code: String = "Sophi64!"
    var emailDetail : PrimaryEmailAcc
    var body: some View {
        NavigationStackView("KeyAccountEmailView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text(emailDetail.email)
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
                           
                            Text(emailDetail.email)
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
                            
                               HStack
                                {
                              
                                    
                                    Text("Associé à \(viewModel.mailAssociations[0].associated_account ?? 0) comptes")
                                                .font(.system(size: 15))
                                                
                                   
                               
                                        
                                    
                                        
                                
                                    
                               
                                    
                         
                                       
                                      
                                       
                                    
                                }
                                .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,44)
                            
                            
                            HStack
                            {
                                Image("lockColor")
                                    .frame(width:26,height:13)
                            
                               HStack
                                {
                              
                                    if isVisible
                                    {
                                        TextField("", text: $code)
                                                .font(.system(size: 15))
                                                .disabled(true)
                                    }
                                    else
                                    {
                                        SecureField("", text: $code)
                                                .font(.system(size: 15))
                                                .disabled(true)
                                    }
                               
                                        
                                    
                                        
                                
                                    
                               
                                    
                         
                                       
                                      
                                       
                                    
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
                                .onTapGesture {
                                    navigationModel.pushContent("KeyAccountEmailView") {
                                        
                                        EnterPasswordView(isEmail: true, emailDetail: emailDetail, phoneDetail: PrimaryPhone(id: 0, name: "", phoneNum: "", pincode: "", deviceUnlockCode: ""))
                                    }
                                }
                                
                                Spacer()
                            }
                            .frame(width:.infinity)
                           
                           
                            Text("Gestion")
                                   .font(.system(size: 17))
                                   .fontWeight(.bold)
                                   .padding(.leading,24)
                                   .padding(.top,40)
                                   .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("phoneNumberIcon")
                                    .frame(width:26,height:13)
                            
                                Text("Gérer le compte (Note)")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            KeyAccountDetailNoteView(title: "Note", description: emailDetail.note)
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            
            code = emailDetail.password
            viewModel.phoneRegAssociated()
        }
        }
    }
}


struct KeyAccountDetailNoteView: View
{
    var title: String
    var description: String
    
    var body: some View {
        ZStack(alignment: .leading){
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            
            VStack(alignment:.leading)
            {
                HStack(alignment:.top){
                 
                        Image("ic_note")
                            .padding(.leading,24)
                            .padding(.top,40)
                Text(title)
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.leading,8)
                       .padding(.bottom,24)
                       .multilineTextAlignment(.leading)
                }
              
                if description.count > 0
                {
                   
                    HStack(alignment:.top){
                     
                           
                        VStack(alignment:.leading)
                        {
                            Text(description)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom,40)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                        }
                        
                            Spacer()
                          
                      
                    }
                   
                    
                 }
                else
                {
                    Spacer()
                }
               
            }
         
        }
        
        .frame(maxWidth:.infinity)
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}


struct KeyAccountEmailView_Previews: PreviewProvider {
    static var previews: some View {
        KeyAccountEmailView(isVisible: false, emailDetail: PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: true))
    }
}

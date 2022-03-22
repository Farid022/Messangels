//
//  SocialNetworkSheetView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import SwiftUI
import NavigationStack

struct SocialNetworkSheetView: View {
    var body: some View {
        NavigationStackView("SocialNetworkSheetView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Instagram")
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
                           
                            Text("Instagram")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            Text("Accès")
                                   .font(.system(size: 17))
                                   .fontWeight(.bold)
                                   .padding(.top,24)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            HStack
                            {
                                Image("ic_key_color_native")
                                    .frame(width:26,height:13)
                            
                                Text("sophie.carnero@gmail.com")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("ic_mobile")
                                    .frame(width:26,height:13)
                            
                                Text("iPhone de Sophie")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            Text("Gestion")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            
                            HStack
                            {
                                Image("ic_link")
                                    .frame(width:26,height:13)
                            
                                Text("www.instagram.com")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("*Clôturer immédiatement/*Mettre un message (Note)")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                           
                            
                            KeyAccountDetailNoteView(title: "Note", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ")
                                .padding(.bottom,24)
                           
                            Group{
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("Ajouter une photo")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            Image("")
                            .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("Clôturer le compte après 1 mois")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                                
                                
                                HStack
                                {
                                    Image("ic_i")
                                        .frame(width:26,height:13)
                                
                                    Text("*J’accepte qu’un compte commémoratif soit créé sur ce réseau social /*Je refuse qu’un compte commémoratif soit créé sur ce réseau social")
                                           .font(.system(size: 15))
                                           .fontWeight(.regular)
                                           .lineLimit(2)
                                           
                                          
                                           .padding(.leading,10)
                                    
                                    
                                }
                                .padding(.leading,24)
                                .padding(.bottom,24)
                                
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

struct SocialNetworkSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SocialNetworkSheetView()
    }
}

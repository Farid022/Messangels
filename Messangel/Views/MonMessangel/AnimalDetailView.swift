//
//  AnimalDetailView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct AnimalDetailView: View {
    @StateObject private var animalsViewModel = AnimalsViewModel()
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Animaux")
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
                           
                          
                            Text("Snoop")
                                    
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,18)
                                   .multilineTextAlignment(.leading)
                                 
                                 
                            Image("snoop")
                                .resizable()
                                .frame(width:128, height: 128)
                                .padding(.leading,18)
                            
                               
                            HStack{
                               
                                
                                Image("giveTo")
                                    .padding(.leading,18)
                            Text("Donner à Mourad Essafi")
                                    
                                   .font(.system(size: 15))
                                   .fontWeight(.bold)
                                   .padding(.leading,12)
                                   .multilineTextAlignment(.leading)
                            }
                            .padding(.top,40)
                            .padding(.bottom,24)
                            
                            HStack{
                               
                                
                                Image("ic_i")
                                    .padding(.leading,18)
                            Text("Espèce – Labrador")
                                    
                                   .font(.system(size: 15))
                                   .fontWeight(.regular)
                                   .padding(.leading,12)
                                   .multilineTextAlignment(.leading)
                            }
                            .padding(.bottom,24)
                          
                            HStack{
                               
                                
                                Image("ic_i")
                                    .padding(.leading,18)
                            Text("Plusieurs animaux")
                                
                                   .font(.system(size: 15))
                                   .fontWeight(.regular)
                                   .padding(.leading,12)
                                   .multilineTextAlignment(.leading)
                            }
                            .padding(.bottom,40)
                                 
                                 
                            
                        }
                       
                    }
                
                }
            }
        }
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView()
    }
}

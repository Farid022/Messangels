//
//  ExpressionView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct ExpressionView: View {
    @StateObject private var wishesListViewModel = WishesListViewModel()
    var animalList = ["Image.jpeg","Doc.pdf","Exemple3.jpeg","Doc.pdf"]
     
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
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
                        Text("Expression libre")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                           
                        Spacer()
                       
                       
                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                        VStack{
                          
                            
                            Text("Voici un complément d’information sur mes volontés")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                            
                            Group
                            {
                                ZStack{
                                    Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                        .ignoresSafeArea()
                                   
                                    VStack(alignment:.leading)
                                    {
                                     
                            Group{
                                   
                               
                                        MonCercueilItem(title: "", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.", image: "")
                                            
                                            LazyVGrid(columns: columns) {
                                                ForEach(enumerating: animalList, id:\.self)
                                                {
                                                    index, item in
                                                    gridItem(title: item)
                                                    
                                                }
                                            }
                                            .padding(.leading,24)
                                            .padding(.trailing,24)
                                            .padding(.bottom,40)
                                        }
                                        
                                        
                                        
                                    }
                                }
                                .cornerRadius(24)
                                .padding(.leading,18)
                                .padding(.trailing,18)
                               
                               
                            }
                    }
                    }
                }
            }
        }
    }
}

struct ExpressionView_Previews: PreviewProvider {
    static var previews: some View {
        ExpressionView()
    }
}

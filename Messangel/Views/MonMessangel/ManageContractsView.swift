//
//  ManageContractsView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/16/22.
//

import SwiftUI

struct ManageContractsView: View {
    var list = ["Digicodes appartement Paris bureau","*NOMDUCODE","*NOMDUCODE","*NOMDUCODE","*NOMDUCODE","*NOMDUCODE"]
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
                        Text("Contrats à gérer")
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
                           
                            Text("Voici la liste de mes contrats à gérer")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                         
                            ZStack{
                                Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                    .ignoresSafeArea()
                               
                                VStack(alignment:.leading)
                                {
                                    
                                    Text("Cette liste contient les coordonnées des  organismes qui gèrent les contrats liés à mon quotidien")
                                           .font(.system(size: 15))
                                           .fontWeight(.regular)
                                           .multilineTextAlignment(.leading)
                                           .padding(.leading,24)
                                           .padding(.top,40)
                                           .padding(.bottom,40)
                                          
                                }
                                
                            }
                            .cornerRadius(24)
                            .padding(.leading,18)
                            .padding(.trailing,18)
                            
                            VStack{
                            
                            ForEach(enumerating: list, id:\.self)
                            {
                                index, item in
                                ListItemImageTitle(type: "ic_codePractice", item: item)
                                   

                            }
                            .padding(.trailing,24)
                            .padding(.leading,24)
                           
                            }
                            
                           
                            
                        }
                    }
                }
            }
        }
    }
}

struct ManageContractsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageContractsView()
    }
}

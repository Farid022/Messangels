//
//  DiffusionNouvelleView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine

struct DiffusionNouvelleView: View {
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
                        Text("Diffusion de la nouvelle")
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
                           
                            Text("Voici mes volontés concernant la diffusion de la nouvelle de mon décès")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                                 
                          
                           
                            FirstContactPeopleView()
                            
                        }
                    }
                }
            }
        }
    }
}

struct FirstContactPeopleView: View
{
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
            
         VStack(alignment:.leading)
         {
             
             
             MonCercueilWithListView(title: "Les personnes à contacter prioritairement", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", items:  [MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact"),MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact"),MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact"),MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact"),MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact"),MesVolenteItem(title: "Prénom Nom 1", type:"ic_contact")])
                 .padding(.top,24)
             
           
         }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}


struct DiffusionNouvelleView_Previews: PreviewProvider {
    static var previews: some View {
        DiffusionNouvelleView()
    }
}

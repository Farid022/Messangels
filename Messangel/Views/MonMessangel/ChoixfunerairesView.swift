//
//  ChoixfunerairesView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine

struct ChoixfunerairesView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
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
                        Text("Choix funéraires")
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
                            
                            Text("Voici mes volontés concernant mes choix funéraires")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                            
                            Group
                            {
                                FunerairesView(title: "Mon rite funéraire : *Inhumation/*Crémation", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.")
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Mon lieu d’inhumation", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.")
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Mon lieu de crémation", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.")
                                    .padding(.bottom,40)
                                MonCercueilView()
                                FunerairesView(title: "Ma tenue", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.") .padding(.bottom,40)
                                
                                FunerairesView(title: "Mes objets et accessoires", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.") .padding(.bottom,40)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FunerairesView: View
{
    var title: String
    var description: String
    
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            
            VStack(alignment:.leading)
            {
                Text(title)
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.leading,24)
                       .padding(.bottom,24)
                HStack(alignment:.top){
                    Image("ic_note")
                    .padding(.leading,24)
                    Text(description)
                           .font(.system(size: 14))
                           .fontWeight(.regular)
                           .padding(.bottom,40)
                           .padding(.leading,16)
                           .padding(.trailing,24)
                    
                }
            }
         
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}

struct MonCercueilItem: View
{
    var title: String
    var description: String
    var image: String
    var body: some View {
        
        VStack(alignment:.leading)
        {
            Text("+ " + title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                  
                   .padding(.bottom,24)
            
            if image.count > 0
            {
                Image(image)
                .padding(.bottom,24)
                .cornerRadius(22)
                .frame(width: 161, height: 207, alignment: .leading)
            }
            if description.count > 0
            {
            HStack(alignment:.top){
                Image("ic_note")
              
                Text(description)
                       .font(.system(size: 14))
                       .fontWeight(.regular)
                       .padding(.bottom,40)
                       .padding(.leading,16)
                       .padding(.trailing,24)
                
            }
            }
            
        }
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}

struct MonCercueilView: View
{
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            VStack(alignment:.leading)
            {
                
                Text("Mon cercueil")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
                Group{
                MonCercueilItem(title: "Matériau de mon cercueil : Sapin", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.", image: "sapin1")
                MonCercueilItem(title: "Forme de mon cercueil : Parisien", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.", image: "sapin1")
                }
                
                
                
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}


struct ChoixfunerairesView_Previews: PreviewProvider {
    static var previews: some View {
        ChoixfunerairesView()
    }
}

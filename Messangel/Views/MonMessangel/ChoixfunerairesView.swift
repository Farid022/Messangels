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
    @StateObject private var funeralChoixViewModel = FuneralChoixViewModel()
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
                                FunerairesView(title: "Mon rite funéraire : " + (funeralChoixViewModel.funeral.burialType?.name ?? ""), description: funeralChoixViewModel.funeral.burial_type_note ?? "")
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Mon lieu d’inhumation", description: funeralChoixViewModel.funeral.placeBurialNote)
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Mon lieu de crémation", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.")
                                    .padding(.bottom,40)
                               
                                MonCercueilView(funeral: funeralChoixViewModel.funeral)
                                    .padding(.bottom,40)
                               
                                FunerairesView(title: "Ma tenue", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.") .padding(.bottom,40)
                                
                                FunerairesView(title: "Mes objets et accessoires", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.") .padding(.bottom,40)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            funeralChoixViewModel.getFuneralChoix { success in
                
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
            if title.count > 0
            {
             Text("+ " + title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                  
                   .padding(.bottom,24)
            }
            
            if image.count > 0
            {
                
                    AsyncImage(url: URL(string: image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom,24)
                    .cornerRadius(22)
                    .frame(width: 161, height: 207, alignment: .leading)
               
            }
            if description.count > 0
            {
            HStack(alignment:.top){
               
                if title.count > 0
                {
                    Image("ic_note")
                    Text(description)
                           .font(.system(size: 14))
                           .fontWeight(.regular)
                           .padding(.bottom,40)
                           .padding(.leading,16)
                           .padding(.trailing,24)
                }
                else
                {
                    Image("ic_note")
                        .padding(.top,24)
                    Text(description)
                           .font(.system(size: 14))
                           .fontWeight(.regular)
                           .padding(.bottom,40)
                           .padding(.leading,16)
                           .padding(.trailing,24)
                           .padding(.top,24)
                }
                
            
                
            }
            }
            
        }
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}

struct MonCercueilView: View
{
    var funeral: FuneralChoixDetail
    @StateObject private var funeralChoixViewModel = FuneralChoixViewModel()
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
                    MonCercueilItem(title: "Matériau de mon cercueil : " + funeral.coffinMaterial!.name , description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.", image: funeral.coffinMaterial!.image ?? "")
                    MonCercueilItem(title: "Forme de mon cercueil : " + funeral.coffinFinish!.name , description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum.", image: funeral.coffinFinish!.image ?? "")
                }
                
                
                
            }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
       
        
    }
}


struct ChoixfunerairesView_Previews: PreviewProvider {
    static var previews: some View {
        ChoixfunerairesView()
    }
}

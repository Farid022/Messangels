//
//  AestheticView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct AestheticView: View {
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
                        Text("Esthétique")
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
                           
                            Text("Voici mes volontés concernant l’esthétique de ma cérémonie")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                        
                            CoffinView()
                                .cornerRadius(24)
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes demandes concernant la décoration", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits concernant la tenue des invités", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits sur les accessoires à faire porter aux invités", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", items: [])
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
    }
}
struct CoffinView: View
{
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            VStack(alignment:.leading)
            {
                
                Text("Mes fleurs")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
                Group{
                    FlowerItem(title: "Lys", description: "", image: "Lys")
                    FlowerItem(title: "Tulipes", description: "", image: "Lys")
                    FlowerItem(title: "Orchidées", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", image: "Lys")
                }
                
                
                
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}


struct FlowerItem: View
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
                .frame(width: 161, height: 207)
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

struct AestheticView_Previews: PreviewProvider {
    static var previews: some View {
        AestheticView()
    }
}

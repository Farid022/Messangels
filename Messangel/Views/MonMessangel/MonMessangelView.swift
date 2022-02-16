//
//  MonMessangelView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/4/22.
//

import SwiftUI
import NavigationStack
import Combine


struct MonMessangelView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStackView("MonMessangelView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Mon Messangel")
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
                            
                         dateView()
                            Group{
                         Image("logo_colored")
                                .padding(.top,40)
                                .padding(.bottom,40)
                         Text("Sophie Carnero")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                        Image("gallery_preview")
                                .frame(width: 62, height: 62)
                                .padding(.top,12)
                                .padding(.bottom,12)
                            
                        Text("Née le 10 Novembre 1960 \nà Paris")
                                    .font(.system(size: 15))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,40)
                            }
                            documentView()
                           
                            Group{
                            Image("ic_mesVolontes")
                                .padding(.bottom,12)
                                .padding(.top,80)
                            Text("Mes volontés")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            }
                          
                            MesVoluntesView()
                            Group{
                           
                                Image("ic_mesMessage")
                                .padding(.bottom,12)
                                .padding(.top,80)
                                Text("Mes messages")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,24)
                                Text("49 Messages prêts à être envoyés \nde manière confidentielle")
                                   .font(.system(size: 15))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            }
                          
                            MesMessageView(items: [MesMessage(icon: "ic_people", title:  "destinataires", count: "25"), MesMessage(icon: "ic_messageVideo", title:  "Messages vidéos", count: "5"), MesMessage(icon: "ic_messageText", title:  "Messages texte", count: "8"), MesMessage(icon: "ic_messageAudio", title:  "Messages audio", count: "8"), MesMessage(icon: "ic_messagePhoto", title:  "photos", count: "25")])
                               
                            Group{
                            Image("ic_vieDigitale")
                                .padding(.bottom,12)
                                .padding(.top,56)
                            Text("Ma Vie Digitale")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            
                            MaVieDigitaleView()
                            }
                            
                            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus")
                                   .font(.system(size: 11))
                                   .fontWeight(.regular)
                                   .multilineTextAlignment(.leading)
                                   .padding(.bottom,40)
                                   .padding(.horizontal,18)
                            
                          
                        }
                       
                    
                        
                    }
                   
                }
            }
        }
        }
       
    }
}

struct dateView: View{
    var body: some View {
   
        ZStack{
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: 66)
            HStack{
            HStack(alignment:.top)
            {
                Image("ic_calendar1")
                
                VStack
                {
                    Text("Date de création\n10 octobre 2022")
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                  
                     
                }
                Spacer()
            }
            .minWidth(163)
      
            Spacer()
            HStack(alignment:.top)
            {
                Image("ic_calendar2")
                VStack
                {
                    Text("Date de création\n10 octobre 2022")
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                    
                        
                }
                Spacer()
            }
            .minWidth(163)
            
            
            }
            .padding(.leading)
            .padding(.trailing)
            
        }
    
    }
        
}

struct documentView: View
{
    var body: some View {
   
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
              
                .cornerRadius(22)
        
            VStack
            {
                Text("Ce document confidentiel comprend mes volontés en cas de décès ainsi que les accès à mes réseaux sociaux et mes services en ligne.")
                       .font(.system(size: 15))
                       .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                       .padding(.top,34)
                       .padding(.leading,24)
                       .padding(.trailing,24)
                       .padding(.bottom,20)
                
                Text("Les messages vidéos, audios et texte que j’ai enregistré via Messangel seront envoyés automatiquement à leurs destinataires.")
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.bottom,24)
                       .padding(.leading,24)
                       .padding(.trailing,24)
                
                Text("Je souhaite que les informations renseignées dans mon Messangel soient transmises aux personnes mentionnées ci-dessous dites « Anges-Gardiens »")
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.bottom,24)
                       .padding(.leading,24)
                       .padding(.trailing,24)
                
                Text("Mme Marianne Milon")
                       .font(.system(size: 15))
                       .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                      
                       .padding(.leading,24)
                       .padding(.trailing,24)
                Text(" Née le 7 octobre 1968 \nà Strasbourg")
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.bottom,20)
                       .padding(.leading,24)
                       .padding(.trailing,24)
                
                Text("Mme Amélie Poulain")
                       .font(.system(size: 15))
                       .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                      
                       .padding(.leading,24)
                       .padding(.trailing,24)
                Text("Née le 15 décembre 1956 \nà Lyon")
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.bottom,18)
                       .padding(.leading,24)
                       .padding(.trailing,24)
               
                Spacer()
               
               
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
       
    
    }
}



//MARK: - MesVoluntes List

struct MesVoluntesView: View
{
    var body: some View {
        Group{
            MesVoluntesListView(items: [MesVolenteItem(title: "Choix funéraires", type:""),MesVolenteItem(title: "Organisme obsèques", type:""),MesVolenteItem(title: "Annonces", type:""),MesVolenteItem(title: "Don d’organes ou du corps", type:"")], title: "Mes choix personnels", description: "")
                .padding(.bottom,40)
            
            MesVoluntesListView(items: [MesVolenteItem(title: "Spiritualité et traditions", type:""),MesVolenteItem(title: "Lieux", type:""),MesVolenteItem(title: "Diffusion de la nouvelle", type:""),MesVolenteItem(title: "Esthétique", type:""),MesVolenteItem(title: "Musique", type:"")], title: "Pour ma cérémonie", description: "")
                .padding(.bottom,40)
            
            
            MesVoluntesListView(items: [MesVolenteItem(title: "Vêtements et accessoires", type:""),MesVolenteItem(title: "Animaux", type:""),MesVolenteItem(title: "Objets", type:""),MesVolenteItem(title: "Dons et collectes", type:"")], title: "Pour ma transmission", description: "")
                .padding(.bottom,40)
                
            MesVoluntesListView(items: [MesVolenteItem(title: "Pièces administratives", type:""),MesVolenteItem(title: "Codes pratiques", type:""),MesVolenteItem(title: "Contrats à gérer", type:""),MesVolenteItem(title: "Expression libre", type:"")], title: "Mes compléments utiles", description: "")
                  
            }
    }
}
struct MesVoluntesListView: View
{
    @EnvironmentObject var navigationModel: NavigationModel
    var items: [MesVolenteItem]
    var title: String
    var description: String
    var body: some View {
   
        
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
              
                .cornerRadius(22)
        
            VStack(alignment:.leading)
            {
                
                Text(title)
                        
                       .font(.system(size: 15))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.leading,24)
                       .padding(.bottom,12)
                       .multilineTextAlignment(.leading)
                
                if description.count > 0
                {
                Text(description)
                        
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .padding(.top,12)
                       .padding(.leading,24)
                       .padding(.bottom,12)
                       .multilineTextAlignment(.leading)
                }
                
                ForEach(enumerating: items, id:\.self)
                {
                    index, item in
                    MesVoluntesItem(type: item.type, item: item.title)
                        

                }
                .padding(.leading,24)
                .padding(.trailing,24)
            }
            .padding(.bottom,40)
        }
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}

struct MesVoluntesItem: View
{
    @EnvironmentObject var navigationModel: NavigationModel
    var type: String
    var item: String
    var body: some View {
        
        VStack
        {
        HStack(alignment:.center)
        {
            if type.count > 0
            {
                Image(type)
                .padding(.leading,24)
             
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,12)
                
            }
            else
            {
               
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,24)
            
             
                }
           
            Spacer()
            Button(action: {}) {
                Image("ic_nextArrow")
            }
            .padding(.trailing,24)
            
        }
        .frame(height:56)
        .background(.white)
        .cornerRadius(22)
       
        }
        .frame(height:68)
        .onTapGesture {
            navigationModel.pushContent("MonMessangelView") {
                
                switch(item)
                {
                case "Choix funéraires" :  ChoixfunerairesView()
                case "Organisme obsèques" :  OrganismesObsequesView()
                case "Animaux" : AnimalsView()
                case "Annonces": AdvertismentView()
                case "Don d’organes ou du corps": CorpsScienceView()
                case "Spiritualité et traditions": SpiritualiteTraditionsView()
                case  "Lieux": PremisesView()
                case "Diffusion de la nouvelle" : DiffusionNouvelleView()
                case   "Esthétique": AestheticView()
                case  "Musique": MusicView()
                case  "Pièces administratives": AdministrativePartsView()
                case  "Dons et collectes": DonationCollectioView()
                case  "Vêtements et accessoires": ClothAccessoriesView()
                case  "Objets": ObjectListView()
                case  "Codes pratiques": CodePractiveView()
                case  "Contrats à gérer": ManageContractsView()
                case  "Expression libre": ExpressionView()
                default: MusicView()
                    
              }
                }
        }
        
    }
}


//MARK: - Mes Messages View
struct MesMessageView: View
{
    var items: [MesMessage]
    
    var body: some View {
        VStack
        {
            ForEach(enumerating: items, id:\.self)
            {
                index, item in
                MesMessageViewItem(title: item.title, image: item.icon, total: item.count)
            }
        }
    }
    
}
struct MesMessageViewItem: View
{
    var title: String
    var image: String
    var total: String
    
    
    var body: some View {
        VStack{
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
                .frame(height: 128)
         
            VStack(alignment:.center)
            {
                Image(image)
                    .padding(.bottom,13)
                Text(total + " " + title)
                       .font(.system(size: 15))
                       .fontWeight(.bold)
            }
            
        }
        .cornerRadius(22)
        .padding(.leading,16)
        .padding(.trailing,16)
        }
        .frame(height:152)
    
    }
}

//MARK: - Ma Vie Digitale View

struct MaVieDigitaleView: View
{
    var body: some View {
        Group{
            MesVoluntesListView(items: [MesVolenteItem(title: "sophie.carnero@gmail.com", type:"ic_email"),MesVolenteItem(title: "carnerosophie68@yahoo.fr", type:"ic_email"),MesVolenteItem(title: "iPhone de Sophie", type:"ic_mobile")], title: "Mes comptes-Clés", description: "Ces comptes mail et smartphone sont associés à mes réseaux sociaux et mes services en ligne")
                .padding(.bottom,40)
            MesVoluntesListView(items: [MesVolenteItem(title: "Réseau sociaux", type:""),MesVolenteItem(title: "Cloud", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:""),MesVolenteItem(title: "Catégorie", type:"")], title: "Mes réseaux sociaux et services en ligne", description: "Utilisez « Réinitialiser le mot de passe » ou « mot de passe oublié » pour gérer mes différents comptes")
                .padding(.bottom,40)
        }
    }
}

struct MonMessangelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MonMessangelView()
        }
    }
}


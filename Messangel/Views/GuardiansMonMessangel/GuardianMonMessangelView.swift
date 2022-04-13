//
//  GuardianMonMessangelView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/30/22.
//

import SwiftUI
import NavigationStack
import Combine
import SwiftUIX
import Foundation

struct GuardianMonMessangelView: View {
    @State private var stored: Int = 0
    @State private var current: [Int] = []
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var guardianViewModel = GuardianViewModel()
    @StateObject private var volontesViewModel = VolontesViewModel()
    @StateObject var auth = Auth()
    @EnvironmentObject var envAuth: Auth
 
    @State private var cgImage = UIImage().cgImage
    
    @State private var profileImage = UIImage()
    @StateObject private var vmKeyAcc = KeyAccViewModel()

  
    var body: some View {
     
        NavigationStackView("GuardianMonMessangelView") {
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
                                Text(envAuth.user.first_name + " " + envAuth.user.last_name)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                
                                if envAuth.user.image_url == nil {
                                    Image("ic_camera")
                                        .frame(width: 62, height: 62)
                                        .padding(.top,12)
                                        .padding(.bottom,12)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .cornerRadius(31)
                                } else {
                               
                                 
                                    
                                    AsyncImage(url: URL(string: envAuth.user.image_url ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                            .frame(width: 62, height: 62)
                                            .padding(.top,12)
                                            .padding(.bottom,12)
                                            .clipShape(Circle())
                                           
                                            
                                }
                                
                     
                               
                                Text("Née le " + envAuth.user.getDOB() + "\nà " + envAuth.user.city)
                                    .font(.system(size: 15))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,40)
                            }
                            documentView(guardians: guardianViewModel.guardians)
                           
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
                          
                            GuardianMesVoluntesView(itemArray: volontesViewModel.tabs)
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
                            
                                if vmKeyAcc.smartphones.count < 1 && vmKeyAcc.keyAccounts.count < 1
                                {
                                    Text("Vous n'avez pas renseigne d'information concermant votre vie digitale")
                                        
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .padding(.top,40)
                                        .padding(.leading,24)
                                        .padding(.bottom,12)
                                        .multilineTextAlignment(.leading)
                                   
                                }
                                
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
        }.onAppear(perform: {
            volontesViewModel.getTabs()
            guardianViewModel.getGuardians { success in
                
            }
      
            vmKeyAcc.getKeyAccounts { success in
                
            }
            vmKeyAcc.getKeyPhones()
            
           
        })
                    
        
       
       
    }
}

struct GuardianMesVoluntesView: View
{
    
    var itemArray : [VolontesTab]
    var body: some View {
        Group{
            
            GuardianMesVoluntesListView(items: itemArray.filter { $0.type == "1"}, title: "Mes choix personnels", description: "", noItemDescription: "Vous n'avez pas renseigne d'information concermant vos volontes")
                .padding(.bottom,40)
            
            GuardianMesVoluntesListView(items: itemArray.filter { $0.type == "2"}, title: "Pour ma cérémonie", description: "", noItemDescription: "Vous n'avez pas cree de messages pour I'instant")
                .padding(.bottom,40)
            
            
            GuardianMesVoluntesListView(items:itemArray.filter { $0.type == "3"}, title: "Pour ma transmission", description: "", noItemDescription: "")
                .padding(.bottom,40)
                
            GuardianMesVoluntesListView(items: itemArray.filter { $0.type == "4"}, title: "Mes compléments utiles", description: "", noItemDescription: "")
                  
            }
    }
}

struct GuardianMesVoluntesItem: View
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
            
          
            navigationModel.pushContent("GuardianMonMessangelView") {
                
                
                switch(item)
                {
                case "Choix funéraires" :  GuardianFuneralChoiceView()
                case "Organismes spécialisés" :  GuardianOrganismesObsequesView()
                case "Animaux" : GuardianAnimalView()
                case "Faire-part et annonce": GuardianAdvertismentView()
                case "Don d’organes ou du corps": GuardianCorpsScienceView()
                case "Spiritualité et traditions": GuardianSpiritualiteTraditionsView()
                case  "Lieux": GuardianPremisesView()
                case "Diffusion de la nouvelle" : GuardianDiffusionNouvelleView()
                case   "Esthétique": GuardianAestheticView()
                case  "Musique": GuardianMusicView()
                case  "Pièces administratives": GuardianAdministrativePartsView()
                case  "Dons": GuardianDonationCollectioView()
                case  "Vêtements et accessoires": GuardianClothAccessoriesView()
                case  "Objets": GuardianObjectListView()
                case  "Codes pratiques": GuardianCodePractiveView()
                case  "Contrats à gérer": GuardianManageContractsView()
                case  "Expression libre": GuardianExpressionView()
                default: GuardianMusicView()
                    
              }
                }
        }
        
    }
}

struct GuardianMesVoluntesListView: View
{
    @EnvironmentObject var navigationModel: NavigationModel
    var items: [VolontesTab]
    var title: String
    var description: String
    var noItemDescription: String?
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
                
                if items.count < 1
                {
                    if noItemDescription?.count ?? 0 > 0
                    {
                        Text(noItemDescription ?? "")
                            
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,40)
                            .padding(.leading,24)
                            .padding(.bottom,12)
                            .multilineTextAlignment(.leading)
                    }
                    
                }
                
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
                    GuardianMesVoluntesItem(type: item.type, item: item.name)
                        

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

struct GuardianMonMessangelView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianMonMessangelView()
    }
}

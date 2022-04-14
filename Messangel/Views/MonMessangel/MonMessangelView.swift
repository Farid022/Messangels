//
//  MonMessangelView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/4/22.
//

import SwiftUI
import NavigationStack
import Combine
import SwiftUIX

struct MonMessangelView: View {
    @State private var stored: Int = 0
    @State private var current: [Int] = []
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var guardianViewModel = GuardianViewModel()
    @StateObject private var volontesViewModel = VolontesViewModel()
    @StateObject private var onlineServiceViewModel = OnlineServiceViewModel()
    @StateObject var auth = Auth()
    @EnvironmentObject var envAuth: Auth
    @State private var cgImage = UIImage().cgImage
    
    @State private var profileImage = UIImage()
    @StateObject private var vmKeyAcc = KeyAccViewModel()

  
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
                          
                            MesVoluntesView(itemArray: volontesViewModel.tabs)
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
            
            onlineServiceViewModel.getCategories()
           
            
        })
                    
        
       
       
    }
}

struct dateView: View{
    @EnvironmentObject var envAuth: Auth
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
                    Text("Date de création\n" + envAuth.user.getRegistrationDate() )
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
                    Text("Date de création\n" + envAuth.user.getUpdatedDate() )
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
    @EnvironmentObject private var navigationModel: NavigationModel
    var guardians: [Guardian]
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
                
                if guardians.count > 0
                {
                   
                   
                        ForEach(enumerating: guardians, id:\.self)
                        {
                            index, item in
                            
                            GuardiansView(name: item.first_name + " " + item.last_name, dateofBirth: item.guardian?.dob ?? "", address: item.guardian?.city ?? "")
                                .padding(.bottom,20)
                        }
                        .padding(.leading,24)
                        .padding(.trailing,24)
                        
                      
                        
                        
                        Text("Ajoutez un deuxieme Ange-gardien pour activer votre Messangel")
                               .font(.system(size: 15))
                               .fontWeight(.regular)
                               .multilineTextAlignment(.center)
                               .padding(.bottom,20)
                               .padding(.leading,24)
                               .padding(.trailing,24)
                        
                        Text("Séquence - Soucription abonnement")
                               .font(.system(size: 15))
                               .fontWeight(.regular)
                               .multilineTextAlignment(.center)
                               .padding(.bottom,20)
                               .padding(.leading,24)
                               .padding(.trailing,24)
                        
                        VStack
                        {
                        
                            Image("add-user")
                            .opacity(1)
                            .frame(width: 50, height:50)
                        }
                        .background(.white)
                        .clipShape(Circle())
                        .frame(width: 50, height:50)
                        .background(.white)
                        .clipShape(Circle())
                        .thinShadow()
                        .onTapGesture {
                            navigationModel.pushContent("MonMessangelView") {
                                GuardianFormIntroView(vm: GuardianViewModel())
                            }
                        
                  
                    }
                    
                }
                else
                {
                    Text("Abonnez-vous pour ajouter vos Anges-gardiens.")
                           .font(.system(size: 15))
                           .fontWeight(.regular)
                           .multilineTextAlignment(.center)
                           .padding(.bottom,20)
                           .padding(.leading,24)
                           .padding(.trailing,24)
                    
                    Text("Séquence - Soucription abonnement")
                           .font(.system(size: 15))
                           .fontWeight(.regular)
                           .multilineTextAlignment(.center)
                           .padding(.bottom,20)
                           .padding(.leading,24)
                           .padding(.trailing,24)
                    
                    
                    
                    Button {
                        navigationModel.pushContent("MonMessangelView") {
                            GuardianFormIntroView(vm: GuardianViewModel())
                        }
                    }label: {
                        Text("Je m’abonne (2€/mois)")
                            .font(.system(size: 15))
                            .padding(20)
                            .foregroundColor(.white)
                        
                    }
                    .background(Color.accentColor)
                    .cornerRadius(20)
                    .frame(width: 280, height:50)
                    
                    
                    
                    
                  
                   
                }
              
              
               
                Spacer()
               
               
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
       
    
    }
}
struct GuardiansView: View
{
    var name: String
    var dateofBirth: String
    var address: String
    var body: some View {
    
        VStack{
            
                Text(name)
                       .font(.system(size: 15))
                       .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                      
                       .padding(.leading,24)
                       .padding(.trailing,24)
                Text(" Née le \(dateofBirth) \nà \(address)")
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .lineLimit(2)
                       .multilineTextAlignment(.center)
                       .padding(.bottom,20)
                       .padding(.leading,24)
                       .padding(.trailing,24)
                
                
        }
    }
}

struct keyAccounts: View
{
    var body: some View {
    
        VStack{}
    }
}


//MARK: - MesVoluntes List

struct MesVoluntesView: View
{
    
    var itemArray : [VolontesTab]
    var body: some View {
        Group{
            
            MesVoluntesListView(items: itemArray.filter { $0.type == "1"}, title: "Mes choix personnels", description: "", noItemDescription: "Vous n'avez pas renseigne d'information concermant vos volontes")
                .padding(.bottom,40)
            
            MesVoluntesListView(items: itemArray.filter { $0.type == "2"}, title: "Pour ma cérémonie", description: "", noItemDescription: "Vous n'avez pas cree de messages pour I'instant")
                .padding(.bottom,40)
            
            
            MesVoluntesListView(items:itemArray.filter { $0.type == "3"}, title: "Pour ma transmission", description: "", noItemDescription: "")
                .padding(.bottom,40)
                
            MesVoluntesListView(items: itemArray.filter { $0.type == "4"}, title: "Mes compléments utiles", description: "", noItemDescription: "")
                  
            }
    }
}
struct MesVoluntesListView: View
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
                    MesVoluntesItem(type: item.type, item: item.name)
                        

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

struct DigitalLifeListView: View
{
    @EnvironmentObject var navigationModel: NavigationModel
    var emailItems: [PrimaryEmailAcc]
    var phoneItems: [PrimaryPhone]
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
                
                ForEach(enumerating: emailItems, id:\.self)
                {
                    index, item in
                    KeyAccountItem(type: "ic_email", item: item.email)
                        .onTapGesture {
                            navigationModel.pushContent("MonMessangelView") {
                                
                                
                                
                                KeyAccountEmailView(isVisible: false, emailDetail: item)
                                
                        

                                }
                        }
                .padding(.leading,24)
                .padding(.trailing,24)
                
                ForEach(enumerating: phoneItems, id:\.self)
                {
                    index, item in
                    KeyAccountItem(type: "ic_mobile", item: item.phoneNum)
                        .onTapGesture {
                            navigationModel.pushContent("MonMessangelView") {
                                
                                
                                
                                KeyAccountPhoneView(isVisible: false, phoneDetail: item)
                                
                        

                                }
                        }
                        

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
}

struct ServiceCategoryListView: View
{
    @EnvironmentObject var navigationModel: NavigationModel
    var items: [ServiceCategory]
    
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
                    ServiceCategoryItem(type: "", item: item.name)
                        .onTapGesture {
                            navigationModel.pushContent("MonMessangelView") {
                                
                                CategoryDetailView(category: item)
                                
                                }
                        }
                        
                        

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
                case "Organismes spécialisés" :  OrganismesObsequesView()
                case "Animaux" : AnimalsView()
                case "Faire-part et annonce": AdvertismentView()
                case "Don d’organes ou du corps": CorpsScienceView()
                case "Spiritualité et traditions": SpiritualiteTraditionsView()
                case  "Lieux": PremisesView()
                case "Diffusion de la nouvelle" : DiffusionNouvelleView()
                case   "Esthétique": AestheticView()
                case  "Musique": MusicView()
                case  "Pièces administratives": AdministrativePartsView()
                case  "Dons": DonationCollectioView()
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

struct ServiceCategoryItem: View
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
//        .onTapGesture {
//            navigationModel.pushContent("MonMessangelView") {
//
//
//                switch(item)
//                {
//                case "Choix funéraires" :  ChoixfunerairesView()
//                case "Organismes spécialisés" :  OrganismesObsequesView()
//                case "Animaux" : AnimalsView()
//                case "Faire-part et annonce": AdvertismentView()
//                case "Don d’organes ou du corps": CorpsScienceView()
//                case "Spiritualité et traditions": SpiritualiteTraditionsView()
//                case  "Lieux": PremisesView()
//                case "Diffusion de la nouvelle" : DiffusionNouvelleView()
//                case   "Esthétique": AestheticView()
//                case  "Musique": MusicView()
//                case  "Pièces administratives": AdministrativePartsView()
//                case  "Dons": DonationCollectioView()
//                case  "Vêtements et accessoires": ClothAccessoriesView()
//                case  "Objets": ObjectListView()
//                case  "Codes pratiques": CodePractiveView()
//                case  "Contrats à gérer": ManageContractsView()
//                case  "Expression libre": ExpressionView()
//                default: MusicView()
//
//              }
//                }
//        }
        
    }
}
struct KeyAccountItem: View
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
    @StateObject private var onlineServiceViewModel = OnlineServiceViewModel()
    @StateObject private var vmKeyAcc = KeyAccViewModel()
    var body: some View {
        Group{
            
           
            DigitalLifeListView(emailItems: vmKeyAcc.keyAccounts, phoneItems: vmKeyAcc.smartphones, title: "Mes comptes-Clés", description: "Ces comptes mail et smartphone sont associés à mes réseaux sociaux et mes services en ligne")
                .padding(.bottom,40)
            ServiceCategoryListView(items: onlineServiceViewModel.categories, title: "Mes réseaux sociaux et services en ligne", description: "Utilisez « Réinitialiser le mot de passe » ou « mot de passe oublié » pour gérer mes différents comptes")
                .padding(.bottom,40)
        }
        .onAppear {
            onlineServiceViewModel.getCategories()
            vmKeyAcc.getKeyAccounts{ success in
                
            }
            vmKeyAcc.getKeyPhones()
        }
    }
}




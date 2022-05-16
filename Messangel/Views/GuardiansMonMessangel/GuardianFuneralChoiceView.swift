//
//  GuardianFuneralChoiceView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/30/22.
//

import SwiftUI
import NavigationStack

struct GuardianFuneralChoiceView: View {

    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var funeralChoixViewModel = FuneralChoixViewModel()
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var guardianViewModel = GuardianMonMessangelViewModel()
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
                                ZStack(alignment:.topTrailing)
                                {
                                    
                                  
                                        GuardianFunerairesView(title: "Mon rite funéraire : " + (funeralChoixViewModel.funeral.burialType?.name ?? ""), description: funeralChoixViewModel.funeral.burial_type_note ?? "")
                                    .padding(.bottom,40)
                                        
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "burial_type" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "burial_type"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                   
                                 
                                 
                                    
                                }
                                
                                ZStack(alignment:.topTrailing)
                                {
                                GuardianFunerairesView(title: "Mon lieu d’inhumation", description: funeralChoixViewModel.funeral.placeBurialNote)
                                    .padding(.bottom,40)
                                    
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "place_burial_note" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "place_burial_note"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                    
                                }
                                
                                ZStack(alignment:.topTrailing)
                                {
                                GuardianFunerairesView(title: "Mon lieu de crémation", description: funeralChoixViewModel.funeral.depositeAshesNote)
                                    .padding(.bottom,40)
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "deposite_ashes_note" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "deposite_ashes_note"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                    
                                    
                                }
                                ZStack(alignment:.topTrailing)
                                {
                                    
                                    GuardianMonCercueilView(funeral: funeralChoixViewModel.funeral)
                                    .padding(.bottom,40)
                                    
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "urn_material" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "urn_material"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                    
                                   
                                        
                                }
                               
                                ZStack(alignment:.topTrailing)
                                {
                                GuardianMonUrneView(funeral: funeralChoixViewModel.funeral)
                                    .padding(.bottom,40)
                                    
                                    
                                    
                                    
                                    
                                    GuardianMemberListView(memebers: [],showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.urnStyle.id)
                                    .padding(.top,-23)
                                }
                               
                                ZStack(alignment:.topTrailing)
                                {
                                GuardianFunerairesView(title: "Ma tenue", description: funeralChoixViewModel.funeral.outfitNote ) .padding(.bottom,40)
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "outfit_note" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "outfit_note"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                   
                                }
                                
                                ZStack(alignment:.topTrailing)
                                {
                                GuardianFunerairesView(title: "Mes objets et accessoires", description: funeralChoixViewModel.funeral.acessoriesNote ) .padding(.bottom,40)
                                    
                                    
                                    if ((guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.contains(where: { $0.tab_field_name == "acessories_note" })) != nil)
                                    {
                                        let filteredArray = guardianMonMessangelViewModel.data.funeralChoice?[0].assign_user?.filter{ $0.tab_field_name == "acessories_note"}
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [] ,showExitAlert: $showExitAlert, id: funeralChoixViewModel.funeral.burialType?.id)
                                            .padding(.top,-23)
                                           
                                    }
                                
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            funeralChoixViewModel.getFuneralChoix { success in
                
            }
            guardianMonMessangelViewModel.getUserGuardianData(guardianID: UserDefaults.standard.value(forKey: "guardianID") as! Int) { success in
                
            }
        }
        if showExitAlert
        {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .overlay(MyAlert(title: "Prendre en charge", message: "Les autres Anges-Gardiens seront prévenu par une notification", ok: "Valider", cancel: "Annuler", action: {
                   
                    guardianMonMessangelViewModel.assignTask(request: assignTaskRequest(tab_name: "Choix funéraires", death_user: getUserId(), obj_id:UserDefaults.standard.value(forKey: "objectID") as? Int) , guardianID: UserDefaults.standard.value(forKey: "guardianID") as! Int) { success in
                   
                    }
                    
                }, showAlert: $showExitAlert))
        }
       
       
       
    }
}
struct GuardianMemberListView: View
{
    var memebers : [User]
    @Binding var showExitAlert : Bool
    var id : Int?
    var body: some View {
        
        VStack(alignment: .trailing)
        {
            HStack(alignment:.top){
            
                GuardianMemberItem(type: "", item: "")
                .onTapGesture {
                    UserDefaults.standard.set(id, forKey: "objectID")
                    showExitAlert = true
                  
                    }
                        
            }
            
        
        }
    }
}
struct GuardianFunerairesView: View
{
    var title: String
    var description: String
    
    var body: some View {
        ZStack(alignment: .leading){
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
                       .multilineTextAlignment(.leading)
              
                if description.count > 0
                {
                   
                    HStack(alignment:.top){
                     
                            Image("ic_note")
                                .padding(.leading,24)
                        VStack(alignment:.leading)
                        {
                            Text(description)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom,40)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                        }
                        
                            Spacer()
                          
                      
                    }
                   
                    
                 }
                else
                {
                    Spacer()
                }
               
            }
           
            
         
        }
        
        .frame(maxWidth:.infinity)
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}

struct GuardianMemberItem: View
{
    var type: String
    var item: String
    var body: some View {
        
        VStack
        {
            
                if type.count > 0
                {
                    AsyncImage(url: URL(string: type)) { image in
                        image
                        .resizable()
                        .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                   
                    .clipShape(Circle())
                    .frame(width:56,height:56)
                 
                    
                }
                else
                {
                    Image("userPlaceholder")
                    .resizable()
                    .clipShape(Circle())
                  
                    .frame(width:56,height:56)
                
                 
                }
            
        }
        .frame(height:56)
        .frame(width:56)
        .padding(.trailing,10)
    }
}

struct GuardianMonCercueilItem: View
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
                   .multilineTextAlignment(.leading)
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
                           .multilineTextAlignment(.leading)
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
                           .multilineTextAlignment(.leading)
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

struct GuardianMonCercueilView: View
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
                    MonCercueilItem(title: "Matériau de mon cercueil : " + funeral.coffinMaterial.name , description: funeral.coffin_material_note ?? "", image: funeral.coffinMaterial.image ?? "")
                    MonCercueilItem(title: "Forme de mon cercueil : " + funeral.coffinFinish.name , description: funeral.coffin_finish_note ?? "", image: funeral.coffinFinish.image ?? "")
                }
                
                
                
            }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
       
        
    }
}

struct GuardianMonUrneView: View
{
    var funeral: FuneralChoixDetail
    @StateObject private var funeralChoixViewModel = FuneralChoixViewModel()
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            VStack(alignment:.leading)
            {
                
                Text("Mon urne")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
                Group{
                    MonCercueilItem(title: "Matériau de mon cercueil : " + funeral.urnMaterial.name, description: funeral.urn_material_note ?? "", image: funeral.urnMaterial.image ?? "")
                    MonCercueilItem(title: "Forme de mon cercueil : " + funeral.urnStyle.name , description: funeral.coffin_finish_note ?? "", image: funeral.urnStyle.image ?? "")
                }
                
                
                
            }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
       
        
    }
}
struct GuardianFuneralChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFuneralChoiceView()
    }
}

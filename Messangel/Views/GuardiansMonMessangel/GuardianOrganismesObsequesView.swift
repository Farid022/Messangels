//
//  OrganismesObsequesView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine
struct GuardianOrganismesObsequesView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var organismesViewModel = OrganismesViewModel()
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
                        Text("Organismes spécialisés")
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
                            Text("Voici mes informations concernant mon entreprise funéraire et mon contrat obsèque")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                          
                            OrganismesItem(title: "Mon entreprise funéraire", description: organismesViewModel.organismes.chose_funeral_home_note ?? "", items: [organismesViewModel.organismes.funeral_company ?? Organismes()])
                                .padding(.bottom,40)
                            
                            FuneralContractView(data: organismesViewModel.organismes)
                                .padding(.bottom,40)
                            
                            if organismesViewModel.organismes.chose_funeral_home == true
                            {
                            
                            MonCercueilTitleView(title: "Je n’ai pas choisi d’entreprise funéraire")
                                .padding(.bottom,40)
                            }
                            
                            if organismesViewModel.organismes.company_contract_detail == true
                            {
                                MonCercueilTitleView(title: "JJe n’ai pas souscrit de contrat obsèques")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            organismesViewModel.getOrganismes { success in
                
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


struct GuardianFuneralContractView: View
{
    var data: OgranismesData
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
            
         VStack(alignment:.leading)
         {

             Text("Mon contrat obsèques")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom,24)
                    .padding(.top,24)
                    .padding(.leading,24)
             
        
             
             MonCercueilWithListView(title: "Organisme", description: "", items:  [data.funeral_company ?? Organismes()])
             
             MonCercueilWithListView(title: "Numéro de contrat", description: "", items:  [])
         }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}
struct GuardianOrganismesItem: View
{
    var title: String
    var description: String
    var items: [Organismes]
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
        VStack(alignment:.leading)
        {
            Text(title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                   .padding(.leading,24)
                   .padding(.bottom,24)
                   .padding(.top,40)
            
            if items.count > 0
            {
                ForEach(enumerating: items, id:\.self)
                {
                    index, item in
                    MesVoluntesItem(type: "ic_company", item: item.name ?? "")

                }
                .padding(.trailing,24)
                .padding(.leading,24)
                .padding(.bottom)
            }
            HStack(alignment:.top){
               
                if description.count > 0
                {
                    Image("ic_note")
                
                    Text(description)
                       .font(.system(size: 14))
                       .fontWeight(.regular)
                       .padding(.bottom,40)
                       .padding(.leading,16)
                       .padding(.trailing,24)
                }
                
            }
            .padding(.leading,24)
           
            
            }
        }
        .cornerRadius(24)
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}
struct GuardianItemWithTitleListDescription: View
{
    var title: String
    var description: String
    var items: [MesVolenteItem]
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
        VStack(alignment:.leading)
        {
            Text(title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                   .padding(.leading,24)
                   .padding(.bottom,24)
                   .padding(.top,40)
            
            if items.count > 0
            {
                ForEach(enumerating: items, id:\.self)
                {
                    index, item in
                    MesVoluntesItem(type: item.type, item: item.title)

                }
                .padding(.trailing,24)
                .padding(.leading,24)
                .padding(.bottom)
            }
            HStack(alignment:.top){
                Image("ic_note")
                
                Text(description)
                       .font(.system(size: 14))
                       .fontWeight(.regular)
                       .padding(.bottom,40)
                       .padding(.leading,16)
                       .padding(.trailing,24)
                
            }
            .padding(.leading,24)
           
            
            }
        }
        .cornerRadius(24)
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}
struct GuardianMonCercueilWithListItem: View
{
    var title: String
    var description: String
    var items: [Organismes]
    var body: some View {
        
        VStack(alignment:.leading)
        {
            Text("+ " + title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                  
                   .padding(.bottom,24)
            
            if items.count > 0
            {
                ForEach(enumerating: items, id:\.self)
                {
                    index, item in
                    MesVoluntesItem(type: "ic_company", item: item.name ?? "")

                }
                
               
                .padding(.bottom)
            }
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
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}

struct GuardianMonCercueilWithListView: View
{
    var title: String
    var description: String
    var items: [Organismes]
    //var items: [MesVolenteItem]
    var body: some View {
        
        VStack(alignment:.leading)
        {
            MonCercueilWithListItem(title: title , description: description, items: items)
        }
                
        
    }
}

struct GuardianMonCercueilTitleView: View
{
    var title: String
 
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
        VStack(alignment:.leading)
        {
            Text(title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                   .multilineTextAlignment(.leading)
                   
        
            
        }
        .padding(.leading,24)
        .padding(.trailing,24)
        .padding(.vertical,40)
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}

struct GuardianOrganismesObsequesView_Previews: PreviewProvider {
    static var previews: some View {
        OrganismesObsequesView()
    }
}

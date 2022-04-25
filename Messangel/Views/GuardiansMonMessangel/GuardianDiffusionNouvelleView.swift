//
//  DiffusionNouvelleView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine

struct GuardianDiffusionNouvelleView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var priorityContactsViewModel = PriorityContactViewModel()
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
                                 
                          
                            ZStack(alignment: .topTrailing)
                            {
                            FirstContactPeopleView(priorityContacts: priorityContactsViewModel.priorityContacts)
                            GuardianMemberListView(memebers: [],showExitAlert: $showExitAlert, id: priorityContactsViewModel.priorityContacts.id)
                                .padding(.top,-23)

                            }
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            priorityContactsViewModel.getPriorityContacts { success in
                
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

struct GuardianFirstContactPeopleView: View
{
    var priorityContacts: PriorityContact
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
            
         VStack(alignment:.leading)
         {
             
             
             PriorityContactListView(title: "Les personnes à contacter prioritairement", description: priorityContacts.priority_note ?? "", items:  priorityContacts.contact ?? [])
                 .padding(.top,24)
             
           
         }
        }
        .cornerRadius(22)
        .padding(.leading,18)
        .padding(.trailing,18)
    }
}


struct GuardianPriorityContactListView: View
{
    var title: String
    var description: String
    var items: [PriorityContactItem]
    var body: some View {
        
        VStack(alignment:.leading)
        {
            PriorityContactListItem(title: title , description: description, items: items)
        }
                
        
    }
}

struct GuardianPriorityContactListItem: View
{
    var title: String
    var description: String
    var items: [PriorityContactItem]
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
                    MesVoluntesItem(type: "ic_contact", item: ((item.first_name ?? "") + " " + (item.last_name ?? "")))

                }
                
               
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
            
        }
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}


struct GuardianDiffusionNouvelleView_Previews: PreviewProvider {
    static var previews: some View {
        DiffusionNouvelleView()
    }
}

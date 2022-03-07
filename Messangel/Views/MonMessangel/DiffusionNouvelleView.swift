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
                                 
                          
                           
                            FirstContactPeopleView(priorityContacts: priorityContactsViewModel.priorityContacts)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            priorityContactsViewModel.getPriorityContacts { success in
                
            }
        }
    }
}

struct FirstContactPeopleView: View
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


struct PriorityContactListView: View
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

struct PriorityContactListItem: View
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


struct DiffusionNouvelleView_Previews: PreviewProvider {
    static var previews: some View {
        DiffusionNouvelleView()
    }
}

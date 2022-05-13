//
//  AestheticView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct GuardianAestheticView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var aestheticViewModel = AestheticViewModel()
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
                        
                            ZStack(alignment: .topTrailing){
                            GuardianCoffinView(aesthetic: aestheticViewModel.asthetic)
                                .padding(.bottom,40)
                                .cornerRadius(24)
                                if aestheticViewModel.asthetic.count > 0
                                {
                                    if ((aestheticViewModel.asthetic[0].assign_user?.contains(where: { $0.tab_field_name == "flower_note" })) != nil)
                                    {
                                        let filteredArray = aestheticViewModel.asthetic[0].assign_user?.filter{ $0.tab_field_name == "flower_note"}
                                      
                                        GuardianMemberListView(memebers: filteredArray?[0].assign_user ?? [],showExitAlert: $showExitAlert, id: aestheticViewModel.asthetic[0].id)
                                            .padding(.top,-23)
                                           
                                    }
                                  
                                }
                                else
                                {
                                    GuardianMemberListView(memebers: [],showExitAlert: $showExitAlert)
                                        .padding(.top,-23)
                                }
                            }
                        
                            
                            ItemWithTitleListDescription(title: "Mes demandes concernant la décoration", description: aestheticViewModel.asthetic[0].special_decoration_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits concernant la tenue des invités", description: aestheticViewModel.asthetic[0].attendence_dress_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits sur les accessoires à faire porter aux invités", description: aestheticViewModel.asthetic[0].guest_accessories_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            aestheticViewModel.getAesthetic { success in
                
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
struct GuardianCoffinView: View
{
    var aesthetic: [Aesthetic]
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                
           
            VStack(alignment:.leading)
            {
                
                Text("Mes fleurs")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
              
                    
                    ForEach(enumerating: aesthetic, id:\.self)
                    {
                        index, item in
                       
                        FlowerItem(title: item.flower?.name ?? "", description: item.flower_note ?? "", image: item.flower?.image ?? "")
                   
                    
                    }
                  
              
                
                
                
                
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
        
    }
}


struct GuardianFlowerItem: View
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
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
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



struct GuardianAestheticView_Previews: PreviewProvider {
    static var previews: some View {
        AestheticView()
    }
}

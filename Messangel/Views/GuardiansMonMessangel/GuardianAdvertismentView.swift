//
//  AdvertismentView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct GuardiansAdvertismentView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var funeralAdvertisementViewModel = FuneralAdvertisementViewModel()
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
                        Text("Faire-part et annonce")
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
                          
                            
                            Text("Voici mes volontés concernant mon faire-part et le choix d’un journal local")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                            
                            Group
                            {
                                GuardianMyAnnoucementView(advertisement: funeralAdvertisementViewModel.advertisement)
                             .padding(.bottom,40)
                                FunerairesView(title: "Journal local", description: funeralAdvertisementViewModel.advertisement.newspaper_note)
                                    .padding(.bottom,40)
                               
                        }
                    }
                    }
                }
            }
        }
        .onAppear {
            funeralAdvertisementViewModel.getAnnounce { success in
                
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


struct GuardiansMyAnnoucementView: View
{
    var animalList : [String] = []
    var advertisement: FuneralAdvertisement
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                .ignoresSafeArea()
           
            VStack(alignment:.leading)
            {
                
                Text("Mon faire-part")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
                
               
                
                Group{
                   
                    MonCercueilItem(title: "Faire apparaitre la photo ci-dessous", description: "", image: advertisement.invitation_photo)
                    MonCercueilItem(title: "Apparence de mon faire-part", description: advertisement.invitation_photo_note ?? "", image: "")
                    MonCercueilItem(title: "Texte à faire apparaître", description: advertisement.theme_note, image: "")
                    
                    LazyVGrid(columns: columns) {
                        ForEach(enumerating: animalList, id:\.self)
                        {
                            index, item in
                            gridItem(title: item)
                            
                        }
                    }
                    .padding(.leading,24)
                    .padding(.trailing,24)
                    .padding(.bottom,40)
                }
                
                
                
            }
        }
        .cornerRadius(24)
        .padding(.leading,18)
        .padding(.trailing,18)
      

    }
}

struct GuardiangridItem: View
{
    var title : String
    var body: some View {
        
        HStack{
        VStack(alignment:.leading)
        {
            
            Text(title)
                   .font(.system(size: 14))
                   .fontWeight(.regular)
                   .padding(.leading,24)
                   .padding(.trailing,24)
            
                  
        }
        .frame(height:56)
        .background(.white)
        .cornerRadius(22)
        }
        .frame(height:68)
        
    }
}
struct GuardiansAdvertismentView_Previews: PreviewProvider {
    static var previews: some View {
        GuardiansAdvertismentView()
    }
}

//
//  MusicView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/16/22.
//

import SwiftUI

struct GuardianMusicView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var musicViewModel = MusicViewModel()
    var animalList = ["Sting – Rise & Fall","Artiste – Nom du morceau","Artiste – Nom du morceau","Artiste – Nom du morceau","Artiste – Nom du morceau"]
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
                        Text("Musique")
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
                           
                            Text("Voici mes volontés concernant la musique à ma cérémonie")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                         
                            ZStack{
                                Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                    .ignoresSafeArea()
                               
                                VStack(alignment:.leading)
                                {
                                    
                                    Text("Cette liste contient les titres que je souhaite faire diffuser à ma cérémonie ou autres moments liés à mes funérailles.")
                                           .font(.system(size: 15))
                                           .fontWeight(.regular)
                                           .multilineTextAlignment(.leading)
                                           .padding(.leading,24)
                                           .padding(.top,40)
                                           .padding(.bottom,40)
                                          
                                }
                                
                            }
                            .cornerRadius(24)
                            .padding(.leading,18)
                            .padding(.trailing,18)
                            
                            VStack{
                            
                                ForEach(enumerating: musicViewModel.musics, id:\.self)
                            {
                                index, item in
                                ZStack(alignment: .topTrailing)
                                {
                                ListItemImageTitle(type: "musicPlaceholder", item: item.song_title)
                                   
                                    GuardianMemberListView(memebers: item.assign_user ?? [],showExitAlert: $showExitAlert, id: item.id)
                                   .padding(.top,-13)
                                   .padding(.trailing,12)
                                }
                                

                            }
                            .padding(.trailing,24)
                            .padding(.leading,24)
                           
                            }
                            
                           
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            musicViewModel.getMusics()
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

struct GuardianMusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}

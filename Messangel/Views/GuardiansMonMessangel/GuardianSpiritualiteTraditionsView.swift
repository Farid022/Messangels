//
//  SpiritualiteTraditionsView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine
struct GuardianSpiritualiteTraditionsView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var spiritualiteViewModel = SpiritualiteViewModel()
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
                        Text("Spiritualité et traditions")
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
                            
                            Text("Voici mes volontés concernant la spiritualité et les traditions au sein de ma cérémonie")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                            
                            Group
                            {
                                ZStack(alignment:.topTrailing)
                                {
                                FunerairesView(title: "Je souhaite une cérémonie " + spiritualiteViewModel.spiritualite.spritual_ceremony.name, description: spiritualiteViewModel.spiritualite.spirtual_cermony_note ?? "")
                                    .padding(.bottom,40)
                                GuardianMemberListView(memebers: [],showExitAlert: $showExitAlert, id: spiritualiteViewModel.spiritualite.id)
                            .padding(.top,-23)

                                }
                
                                
                                ZStack(alignment:.topTrailing)
                                {
                                FunerairesView(title: "Je souhaite faire appliquer des traditions", description: spiritualiteViewModel.spiritualite.ceremony_note ?? "")
                                    .padding(.bottom,40)
                                GuardianMemberListView(memebers: [],showExitAlert: $showExitAlert, id: spiritualiteViewModel.spiritualite.id)
                            .padding(.top,-23)

                                }
                        }
                    }
                    }
                }
            }
        }
        .onAppear {
            spiritualiteViewModel.getspiritualite { success in
                
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

struct GuardianSpiritualiteTraditionsView_Previews: PreviewProvider {
    static var previews: some View {
        SpiritualiteTraditionsView()
    }
}

//
//  PremisesView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct GuardianPremisesView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var premisesViewModel = PremisesViewModel()
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
                        Text("Lieux")
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
                           
                            Text("Voici les différents lieux concernés lors du déroulement de mes funérailles")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                                 
                          
                           
                            ItemWithTitleListDescription(title: "Mon lieu de cérémonie", description: premisesViewModel.newPremises.bury_location_note ?? "", items: [MesVolenteItem(title: premisesViewModel.newPremises.bury_location?.name ?? "", type:"ic_company")])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Je ne souhaite pas indiquer le lieu de ma cérémonie", description: premisesViewModel.newPremises.location_of_ceremony_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mon lieu de repos : Funérarium", description: premisesViewModel.newPremises.resting_place_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mon lieu de repos : Domicile", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ", items: [])
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            premisesViewModel.getPremises { success in
                
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

struct GuardianPremisesView_Previews: PreviewProvider {
    static var previews: some View {
        PremisesView()
    }
}

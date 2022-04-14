//
//  PremisesView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct PremisesView: View {
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
                            
                            ItemWithTitleListDescription(title: "Mon lieu de repos : Domicile", description: premisesViewModel.newPremises.resting_place_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            premisesViewModel.getPremises { success in
                
            }
        }
    }
}

struct PremisesView_Previews: PreviewProvider {
    static var previews: some View {
        PremisesView()
    }
}

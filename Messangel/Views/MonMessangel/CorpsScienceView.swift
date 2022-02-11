//
//  CorpsScienceView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine
struct CorpsScienceView: View {
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
                        Text("Don d’organes ou du corps à la science")
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
                            
                            Text("Voici mes volontés concernant le don d’organes ou du corps à la science")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                            
                            
                            Group
                            {
                                FunerairesView(title: "Je choisis de donner mes organes", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                                FunerairesView(title: "Je refuse de donner mes organes : je suis enregistré au registre national des refus", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Je choisis de donner mon corps à la science", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                        }
                    }
                        
                    }
                }
            }
        }
    }
}

struct CorpsScienceView_Previews: PreviewProvider {
    static var previews: some View {
        CorpsScienceView()
    }
}

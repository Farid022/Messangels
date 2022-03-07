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
    @StateObject private var organViewModel = OrganViewModel()
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
                                
                                
                                ForEach(enumerating: organViewModel.organ, id:\.self)
                                    {
                                        index, item in
                                        FunerairesView(title: item.donation?.name ?? "", description: item.donation_note ?? "")
                                            .padding(.bottom,40)

                                    }
                              
                        }
                    }
                        
                    }
                }
            }
        }
        .onAppear {
            organViewModel.getOrganDonation { success in
                
            }
        }
    }
}

struct CorpsScienceView_Previews: PreviewProvider {
    static var previews: some View {
        CorpsScienceView()
    }
}

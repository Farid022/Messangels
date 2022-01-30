//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct AnimalDonationDetails: View {
    var title: String
    var note: String
    
    var body: some View {
        ZStack(alignment:.top) {
            Color.accentColor
                .frame(height:70)
                .edgesIgnoringSafeArea(.top)
            VStack(spacing: 20) {
                Color.accentColor
                    .frame(height:90)
                    .padding(.horizontal, -20)
                    .overlay(
                        HStack {
                            BackButton()
                            Spacer()
                        }, alignment: .top)
                
                VStack {
                    Color.accentColor
                        .frame(height: 35)
                        .overlay(Text("ANIMAUX")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding([.leading, .bottom])
                                 ,
                                 alignment: .leading)
                    Color.white
                        .frame(height: 15)
                }
                .frame(height: 50)
                .padding(.horizontal, -16)
                .padding(.top, -16)
                .overlay(HStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                        .cornerRadius(25)
                        .normalShadow()
                        .overlay(Image("info"))
                })
                //
                HStack {
                    // <
                    Text(title)
                        .font(.system(size: 22), weight: .bold)
                    Spacer()
                }
                HStack {
                    Image("ic_arrow_right")
                    Text("Donner à Mourad Essafi")
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack {
                    Image("ic_item_info")
                    Text("Espèce – Labrador")
                    Spacer()
                }
                HStack {
                    Image("ic_item_info")
                    Text("Plusieurs animaux")
                    Spacer()
                }
                DetailsNoteView(note: note)
                HStack {
                    Group {
                        Button(action: {}, label: {
                            Text("Modifier")
                        })
                        Button(action: {}, label: {
                            Text("Supprimer")
                        })
                    }
                    .buttonStyle(MyButtonStyle(padding: 0, maxWidth: false, foregroundColor: .black))
                    .normalShadow()
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

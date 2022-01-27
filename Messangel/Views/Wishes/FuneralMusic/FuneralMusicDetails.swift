//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicDetails: View {
    var title: String
    var artist: String
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
                        .overlay(Text("Musique")
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
                    Text("\(artist) - \(title)")
                        .font(.system(size: 22), weight: .bold)
                    Spacer()
                }
                HStack {
                    Image("ic_item_info")
                    Text("Artiste –  \(artist)")
                    Spacer()
                }
                HStack {
                    Image("ic_item_info")
                    Text("Nom du titre –  \(title)")
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(height: 430)
                    .overlay(VStack {
                        HStack{
                            Image("ic_note")
                            Text("Note")
                                .font(.system(size: 15), weight: .bold)
                            Spacer()
                        }
                        Text(note)
                    }
                    .padding()
                    )
                    .padding(.bottom, 30)
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

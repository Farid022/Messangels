//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct ManagedContractsDetails: View {
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
                        .overlay(Text("Contrats à gérer")
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
                    Text("Banque")
                        .font(.system(size: 22), weight: .bold)
                    Spacer()
                }
                HStack {
                    Image("ic_item_info")
                    Text("BNP Paribas Paris 16")
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

//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct PracticalCodeDetails: View {
    var title: String
    
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
                        .overlay(Text("Codes pratiques")
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
                    Text("Digicodes appartement Paris")
                        .font(.system(size: 22), weight: .bold)
                    Spacer()
                }
                HStack {
                    Image("ic_lock_color_native")
                    Text("•••••• (Code 1)")
                    Spacer()
                }
                HStack {
                    Image("ic_lock_color_native")
                    Text("•••••••• (Code 2)")
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
                        Text("""
                                Lorem ipsum dolor sit amet, consetetur
                                sadipscing elitr, sed diam nonumy
                                eirmod tempor invidunt ut labore et
                                dolore magna aliquyam erat, sed diam
                                voluptua. At vero eos et accusam et justo
                                duo dolores et ea rebum. Stet clita kasd
                                gubergren, no sea takimata sanctus est
                                Lorem ipsum dolor sit amet. Lorem ipsum
                                dolor sit amet, consetetur sadipscing
                                elitr, sed diam nonumy.
                                
                                Lorem ipsum dolor sit amet, consetetur
                                sadipscing elitr, sed diam nonumy
                                eirmod tempor invidunt ut labore et
                                dolore magna aliquyam erat, sed diam
                                voluptua.
                                """)
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

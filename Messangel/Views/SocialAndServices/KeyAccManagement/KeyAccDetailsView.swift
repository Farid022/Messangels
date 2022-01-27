//
//  KeyAccDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct KeyAccDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    var email: String
    var note: String
    var confirmMessage = """
ATTENTION
En supprimant ce compte mail, vous supprimerez l’accès à 20 comptes (réseaux sociaux ou services en ligne)
"""
    
    var body: some View {
        ZStack {
            if showDeleteConfirm {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Supprimer ce compte-clé", message: confirmMessage, action: {
                        navigationModel.pushContent("KeyAccDetailsView") {
                            KeyAccRegSecView(keyAccCase: .delEmail)
                        }
                    }, showAlert: $showDeleteConfirm))
            }
            NavigationStackView("KeyAccDetailsView") {
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
                                .overlay(Text("Comptes-clés")
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
                        HStack {
                            Text("< \(email)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        ExtractedView()
                        if !note.isEmpty {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(.gray.opacity(0.2))
                                .frame(height: 400)
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
                        }
                        HStack {
                            Group {
                                Button(action: {}, label: {
                                    Text("Modifier")
                                })
                                Button(action: {
                                    showDeleteConfirm.toggle()
                                }, label: {
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
    }
}

struct ExtractedView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_key_color_native")
                Text("Associé à 5 comptes")
                Spacer()
            }
            HStack {
                Image("ic_lock_color_native")
                Text("••••••••")
                Spacer()
            }
            HStack {
                Text("Gestion")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text("Gérer le compte (Note)")
                Spacer()
            }
        }
    }
}

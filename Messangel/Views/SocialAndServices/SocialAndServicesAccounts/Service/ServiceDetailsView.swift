//
//  ServiceDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/21/21.
//

import SwiftUI
import NavigationStack

struct ServiceDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    var serviceName: String
    var note: String
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    
    var body: some View {
        ZStack {
            if showDeleteConfirm {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Supprimer ce compte-clé", message: confirmMessage, action: {
                        navigationModel.pushContent("ServiceDetailsView") {
                            KeyAccRegSecView(keyAccCase: .delEmail)
                        }
                    }, showAlert: $showDeleteConfirm))
                    .zIndex(1.0)
            }
            NavigationStackView("ServiceDetailsView") {
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
                            Text("< \(serviceName)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        ServiceDetailsSubView()
                        if !note.isEmpty {
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
                        } else {
                            /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
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

struct ServiceDetailsSubView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_key_color_native")
                Text("sophie.carnero@gmail.com")
                Spacer()
            }
            HStack {
                Image("ic_phone")
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
                Text("iPhone de Sophie")
                Spacer()
            }
            HStack {
                Text("Gestion")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text("www.ne.com")
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

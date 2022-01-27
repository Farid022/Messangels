//
//  SmartphoneDetailsView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct SmartphoneDetailsView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    var phoneName: String
    var confirmMessage = """
ATTENTION
En supprimant ce smartphone, vous supprimerez l’accès à 12 comptes (réseaux sociaux ou services en ligne)
"""
    var body: some View {
        ZStack {
            if showDeleteConfirm {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Supprimer ce smartphone", message: confirmMessage, action: {
                        navigationModel.pushContent("SmartphoneDetailsView") {
                            KeyAccRegSecView(keyAccCase: .delPhone)
                        }
                    }, showAlert: $showDeleteConfirm))
            }
            NavigationStackView("SmartphoneDetailsView") {
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
                            Text("< \(phoneName)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        ExtractedSubView()
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

struct ExtractedSubView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Accès")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_key_color_native")
                Text("Associé à 0 compte")
                Spacer()
            }
            HStack {
                Image("ic_lock_color_native")
                Text("•••• (PIN)")
                Spacer()
            }
            HStack {
                Image("ic_lock_color_native")
                Text("•••••• (Code de dévérouillage)")
                Spacer()
            }
            HStack {
                Text("Numéro")
                    .font(.system(size: 17), weight: .bold)
                Spacer()
            }
            HStack {
                Image("ic_item_info")
                Text("06 00 00 00 00")
                Spacer()
            }
        }
    }
}


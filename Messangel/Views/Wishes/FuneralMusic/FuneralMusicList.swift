//
//  FuneralMusicList.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var funeralItems = ["Sting – Rise & Fall", "Artiste – Nom du morceau"]
    var body: some View {
        FuneralItemList(id:"FuneralMusicList", menuTitle: "Musique") {
            ForEach(funeralItems, id: \.self) { item in
                FuneralItemCard(title: item, icon: "ic_music_white")
                    .onTapGesture {
                        navigationModel.pushContent("FuneralMusicList") {
                            FuneralMusicDetails(title: item.components(separatedBy: " – ")[1], artist: item.components(separatedBy: " – ")[0])
                        }
                    }
            }
        }
    }
}

struct FuneralItemList<Content: View>: View {
    let id: String
    let menuTitle: String
    let content: Content
    init(id: String, menuTitle: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.id = id
        self.menuTitle = menuTitle
    }
    var body: some View {
        NavigationStackView(id) {
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
                            .overlay(Text(menuTitle)
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
                    Spacer().frame(height: 17)
                    content
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct FuneralItemCard: View {
    var title: String
    var icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .frame(height: 96)
            .overlay(HStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.gray)
                    .frame(width: 56, height: 56)
                    .overlay(Image(icon))
                    .padding(.leading)
                Text(title)
                Spacer()
            })
            .normalShadow()
    }
}

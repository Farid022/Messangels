//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack
import AVFoundation

struct VideoTitleView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var groupVM: GroupViewModel

    var filename: URL
    var selectedFilter: Color
    @State var title = ""
    @State var valid = false
    
    var body: some View {
        NavigationStackView("VideoTitleView") {
            MenuBaseView(height: 60, title: "Filtre") {
                ZStack {
                    VideoPreview(fileUrl: filename)
                        .frame(width: 106, height: 197.76)
                    Rectangle()
                        .foregroundColor(selectedFilter.opacity(0.15))
                        .frame(width: 106, height: 197.76)
                }
                .padding(.bottom, 25)
                Text("Choisir un titre")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.top, -20)
                TextField("Titre de la vidéo", text: $title, onCommit: {
                    valid = !title.isEmpty
                })
                    .textFieldStyle(MyTextFieldStyle())
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.accentColor.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .overlay(
                            Button(action: {
                                navigationModel.pushContent("VideoTitleView") {
                                    VideoGroupView(filename: filename, selectedFilter: selectedFilter)
                                }
                            }) {
                                Image(systemName: "chevron.right").foregroundColor(Color.white)
                            }
                        )
                }
            }
        }
    }
}

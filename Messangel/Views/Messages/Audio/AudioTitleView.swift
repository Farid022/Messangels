//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack

struct AudioTitleView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var groupVM: GroupViewModel
    var filename: URL
    @State var title = ""
    @State var valid = false
    
    var body: some View {
        NavigationStackView("AudioTitleView") {
            MenuBaseView(height: 60, title: "Filtre") {
                Text("Aperçu")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                AudioPreview(fileUrl: filename)
                Text("Choisir un titre")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.top, -20)
                TextField("Titre de la audéo", text: $title, onCommit: {
                    valid = !title.isEmpty
                })
                    .textFieldStyle(MyTextFieldStyle())
                    .normalShadow()
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.accentColor.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .overlay(
                            Button(action: {
                                navigationModel.pushContent("AudioTitleView") {
                                    AudioGroupView(filename: filename)
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

struct AudioPreview: View {
    var fileUrl: URL
    var body: some View {
        Image("Audio_Waves")
    }
}

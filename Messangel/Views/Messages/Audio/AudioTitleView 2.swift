//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack

struct AudioTitleView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var groupVM: GroupViewModel
    @StateObject private var vm = AudioViewModel()
    @State private var valid = false
    var fileUrl: URL
    
    var body: some View {
        NavigationStackView("AudioTitleView") {
            MenuBaseView(height: 60, title: "Filtre") {
                Text("Aperçu")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 460)
                    .padding(.horizontal, 30)
                Text("Choisir un titre")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.top, -20)
                TextField("Titre de la audéo", text: $vm.audio.name, onCommit: {
                    valid = !vm.audio.name.isEmpty
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
                                    AudioGroupView(fileUrl: fileUrl, vm: vm)
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

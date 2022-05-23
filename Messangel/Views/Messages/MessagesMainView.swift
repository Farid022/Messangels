//
//  MessagesMainView.swift
//  Messangel
//
//  Created by Saad on 2/23/22.
//

import SwiftUI
import NavigationStack

struct MessagesMainView: View {
    @Binding var showButtonsPopup: Bool
    @ObservedObject var vm: GroupViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if vm.groups.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                            .padding(.bottom)
                        Text("Créez votre premier message")
                            .font(.system(size: 17), weight: .bold)
                    }
                } else {
                        VStack {
                            ForEach(vm.groups, id: \.self) { group in
                                GroupCapsule(group: group)
                                    .environmentObject(vm)
                                    .padding(.vertical)
                            }
                            Spacer().frame(height: 70)
                        }
                        .padding(.horizontal)
                }
            }
        }
        .task() {
            vm.getAll()
        }
    }
}

struct PopupButtonsView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var showPopUp: Bool
    @ObservedObject var vm: GroupViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack(spacing: 40.0) {
                Spacer()
                HStack{
                Text("Audio")
                    .frame(width: 70, height:30)
                   
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        showPopUp = false
                        navigationModel.pushContent(TabBarView.id) {
                            AudioRecorderView()
                                .environmentObject(vm)
                        }
                    }
                Button {
                    showPopUp = false
                    navigationModel.pushContent(TabBarView.id) {
                        AudioRecorderView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_audio"))
                }
                }
                
                HStack{
                Text("Texte")
                    .frame(width: 70, height:30)
                   
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        showPopUp = false
                        navigationModel.pushContent(TabBarView.id) {
                            TextEditorView()
                                .environmentObject(vm)
                        }
                    }
                Button {
                    showPopUp = false
                    navigationModel.pushContent(TabBarView.id) {
                        TextEditorView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_text"))
                }
                }
               
                HStack{
                Text("Video")
                    .frame(width: 70, height:30)
                   
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        showPopUp = false
                        navigationModel.pushContent(TabBarView.id) {
                            VideoRecoderView()
                                .environmentObject(vm)
                        }
                    }
                Button {
                    showPopUp = false
                    navigationModel.pushContent(TabBarView.id) {
                        VideoRecoderView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_video"))
                }
                }
                HStack{
                Text("")
                    .frame(width: 70, height:30)
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                Button {
                    showPopUp.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .foregroundColor(.white)
                        .overlay(Image(systemName: "minus"))
                }
                    
                }
                Spacer().frame(height: UIDevice().hasNotch ? 85 : 80)
            }
            .padding(.trailing)
        }
        .zIndex(1)
        .onTapGesture {
            showPopUp.toggle()
        }
    }
}

struct NewMessageButtonView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var showButtonsPopup: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        showButtonsPopup.toggle()
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .foregroundColor(.accentColor)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                }
            }
            Spacer().frame(height: UIDevice().hasNotch ? 90 : 120)
        }
        .padding(.horizontal)
       
    }
}

struct GroupCapsule: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var albumVM = AlbumViewModel()
    var group: MsgGroupDetail
    var tappable = true
    var width = 0
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .if(width > 0) {$0.frame(width: 340, height: 110)}
            .if(width == 0) {$0.frame(height: 110)}
            .normalShadow()
            .overlay(
                Group {
                    if tappable {
                        Button(action: {
                            navigationModel.pushContent(TabBarView.id) {
                                    MessagesGroupView(group: group)
                                        .environmentObject(albumVM)
                            }
                        }) {
                            GroupItem(group: group)
                        }
                    } else {
                        GroupItem(group: group)
                    }
                }
                .padding(.horizontal, 20),
                alignment: .leading
            )
    }
}

struct GroupItem: View {
    var group: MsgGroupDetail
    var mediaCount: Int {
        var mediaCount = 0
        if let texts = group.texts {
            mediaCount += texts.count
        }
        if let audios = group.audios {
            mediaCount += audios.count
        }
        if let videos = group.videos {
            mediaCount += videos.count
        }
        return mediaCount
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 56, height: 56)
                .foregroundColor(.gray)
                .overlay(Image("ic_public"))
            VStack(alignment: .leading, spacing: 7.0) {
                Text(group.permission == "2" ? "Tout le monde (public)": group.name)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(group.permission == "2" ? "Pour votre cérémonie et tout autre diffusion publique" : ((group.group_contacts?.isEmpty) != nil) ? "Inactif : Pas de destinataires" : "\(group.group_contacts?.count ?? 0) personnes")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
                    .font(.system(size: 13))
                HStack {
                    Image("ic_public_media")
                    if !group.name.isEmpty {
                        Text("\(mediaCount) MÉDIA")
                            .font(.system(size: 9))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

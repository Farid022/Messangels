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
//                    ScrollView {
                        VStack {
                            ForEach(vm.groups, id: \.self) { group in
                                GroupCapsule(group: group)
                                    .environmentObject(vm)
                                    .padding(.vertical)
                            }
                            Spacer().frame(height: 70)
                        }
                        .padding(.horizontal)
//                    }
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
                Button {
                    showPopUp.toggle()
                    navigationModel.pushContent(TabBarView.id) {
                        AudioRecorderView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_audio"))
                }
                Button {
                    navigationModel.pushContent(TabBarView.id) {
                        TextEditorView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_text"))
                }
                Button {
                    navigationModel.pushContent(TabBarView.id) {
                        VideoRecoderView()
                            .environmentObject(vm)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .overlay(Image("ic_video"))
                }
                Button {
                    showPopUp.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .foregroundColor(.white)
                        .overlay(Image(systemName: "minus"))
                }
                Spacer().frame(height: 85)
            }
            .padding(.trailing)
        }
        .zIndex(1)
    }
}

struct NewMessageButtonView: View {
    @Binding var showButtonsPopup: Bool
    var body: some View {
        VStack {
            Spacer()
            Button {
                withAnimation {
                    showButtonsPopup.toggle()
                }
            } label: {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 56, height: 56)
                        .foregroundColor(.accentColor)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                }
            }
            Spacer().frame(height: 90)
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
                                navigationModel.pushContent("Messages") {
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
                        let texts = group.texts?.count ?? 0
                        let audios = group.audios?.count ?? 0
                        let videos = group.audios?.count ?? 0
                        Text("\(texts + audios + videos) MÉDIA")
                            .font(.system(size: 9))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

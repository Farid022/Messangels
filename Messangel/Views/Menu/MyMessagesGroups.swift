//
//  MyMessagesGroups.swift
//  Messangel
//
//  Created by Saad on 6/21/22.
//

import SwiftUI
import NavigationStack

struct MyMessagesGroups: View {
    var contactGroups: [ContactMsgGroup]
    var firstName: String
    var lastName: String
    var userId: Int
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(height: 60, title:"Messages de \(firstName) \(lastName)") {
                VStack {
                    ForEach(contactGroups, id: \.self) { group in
                        ContactGroupCapsule(group: group, userId: userId, navId: String(describing: Self.self))
                            .padding(.vertical)
                    }
                    Spacer().frame(height: 70)
                }
            }
        }
    }
}

struct ContactGroupCapsule: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var albumVM = AlbumViewModel()
    var group: ContactMsgGroup
    var userId: Int
    var navId: String
    var msgGroup: MsgGroupDetail {
        return MsgGroupDetail(id: group.id, name: group.name, user: userId, permission: group.permission, group_contacts: group.group_contacts, texts: group.texts, audios: group.audios, videos: group.videos, galleries: group.galleries)
    }
    var width = 0
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .if(width > 0) {$0.frame(width: 340, height: 110)}
            .if(width == 0) {$0.frame(height: 110)}
            .normalShadow()
            .overlay(
                Button(action: {
                    navigationModel.pushContent(navId) {
                        MessagesGroupView(group: msgGroup, height: 60.0)
                                .environmentObject(albumVM)
                    }
                }) {
                    GroupItem(group: msgGroup)
                }
                .padding(.horizontal, 20),
                alignment: .leading
            )
    }
}

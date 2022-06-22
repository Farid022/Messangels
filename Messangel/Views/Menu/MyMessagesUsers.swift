//
//  MyMessagesList.swift
//  Messangel
//
//  Created by Saad on 6/17/22.
//

import SwiftUI
import NavigationStack

struct MyMessagesUsers: View {
    @EnvironmentObject private var navModel: NavigationModel
    @StateObject private var vm = GroupViewModel()
    @State private var users = [User]()
    @State private var loading = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    //    let columns = [GridItem(.adaptive(minimum: 120), spacing: 8)]
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(height: 60, title:"Les messages de mes proches") {
                if loading {
                    Loader()
                }
                else if self.users.isEmpty {
                    Spacer().frame(height: (screenSize.height / 2) - 120.0)
                    Text("Vous n’avez pas de message")
                        .font(.system(size: 17), weight: .semibold)
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: columns){
                        ForEach(users, id: \.self) { user in
                            MyMessageCard(imageUrl: user.image_url, firstName: user.first_name, lastName: user.last_name)
                                .onTapGesture {
                                    navModel.pushContent(String(describing: Self.self)) {
                                        MyMessagesGroups(contactGroups: vm.contactGroups.filter({$0.user.contains(user)}), firstName: user.first_name, lastName: user.last_name, userId: user.id ?? 0)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .onDidAppear {
            loading.toggle()
            vm.getContactGroups { success in
                if success {
                    for group in vm.contactGroups {
                        self.users.append(contentsOf: group.user)
                    }
                    if !self.users.isEmpty {
                        self.users = Array(Set(self.users))
                    }
                    loading.toggle()
                }
            }
        }
    }
}

struct MyMessageCard: View {
    var imageUrl: String?
    var firstName: String
    var lastName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .frame(width: 157.5, height: 180)
                .normalShadow()
            VStack {
                ProfileImageView(imageUrlString: imageUrl)
                Text(firstName)
                    .font(.system(size: 13))
                Text(lastName)
                    .font(.system(size: 13), weight: .semibold)
            }
        }
    }
}

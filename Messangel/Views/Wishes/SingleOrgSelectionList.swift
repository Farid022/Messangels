//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct SingleOrgSelectionList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un organisme"
    @State private var isEditing = false
    @State private var refreshList = false
    @StateObject private var vm = OrgViewModel()
    @Binding var orgId: Int
    @Binding var orgName: String
    var orgType: Int
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 150)
                    .overlay(
                        VStack {
                            HStack {
                                BackButton(icon:"chevron.down")
                                    .padding(.leading)
                                Spacer()
                                Text("Sélectionnez un organisme")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            HStack {
                                TextField(placeholder, text: $searchString)
                                    .textFieldStyle(MyTextFieldStyle())
                                    .onTapGesture {
                                        isEditing = true
                                        placeholder = ""
                                    }
                                    .if(!isEditing) {$0.overlay(
                                        HStack {
                                            Image("ic_search")
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading, 8)
                                        }
                                    )}
                                Button(action: {}, label: {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundColor(.white)
                                        .frame(width: 56, height: 56)
                                        .overlay(Image("ic_sort"))
                                })
                            }
                            .padding()
                        }, alignment: .bottom)
                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: 20)
                    Button(action: {
                        navigationModel.presentContent(String(describing: Self.self)) {
                            CreateOrgView(type: "\(orgType)", refresh: $refreshList)
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.accentColor)
                            .frame(height: 56)
                            .overlay(
                                HStack {
                                    Image("ic_add_org")
                                        .padding(.leading)
                                    Text("Nouvel Organisme")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            )
                    }
                    .padding(.bottom)
                    ForEach(vm.orgs.filter({ searchString.isEmpty ? true : $0.name.contains(searchString)}), id:\.self) { company in
                        ListItemView(name: company.name) {
                            orgId = company.id ?? 0
                            orgName = company.name
                            navigationModel.hideTopView()
                        }
                    }
                }
                .padding()
            }
        }
        .onDidAppear {
            vm.getOrgs(orgType)
        }
        .onChange(of: refreshList) { _ in
            vm.getOrgs(orgType)
        }
    }
}

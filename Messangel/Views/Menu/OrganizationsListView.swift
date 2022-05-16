//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct OrganizationsListView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un organisme"
    @State private var isEditing = false
    @State private var refreshList = false
    @State private var sortByFirstName = true
    @StateObject private var vm = OrgViewModel()
    
    var body: some View {
        NavigationStackView("OrganizationsListView") {
            MenuBaseView(title: "Liste de organismes") {
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
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: 56, height: 56)
                        .overlay(Button(action: {
                            sortByFirstName.toggle()
                            if sortByFirstName {
                                vm.orgs.sort(by: { $0.name < $1.name })
                            } else {
                                vm.orgs.sort(by: { $0.name > $1.name })
                            }
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.accentColor)
                        })
                }
                .padding()
                .background(Color.accentColor)
                .padding(.horizontal, -16)
                .padding(.top, -16)
                Spacer().frame(height: 25)
                Button {
                    navigationModel.pushContent("OrganizationsListView") {
                        CreateOrgView(vm: vm, type: "9", height: 105, refresh: $refreshList)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.accentColor)
                        .frame(height: 56)
                        .overlay(
                            HStack {
                                Image("ic_add_org")
                                    .padding(.leading)
                                Text("Nouveau Organisme")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        )
                }
                Spacer().frame(height: 25)
                ForEach(vm.orgs.filter({ searchString.isEmpty ? true : $0.name.contains(searchString)}), id:\.self) { org in
                    ContactView(lastName: org.name, firstName: "")
                        .onTapGesture {
                            navigationModel.pushContent("OrganizationsListView") {
                                OrganizationEditView(vm: vm, org: .constant(org))
                            }
                        }
                }
            }
            .onDidAppear() {
                vm.getOrgs(9)
            }
            .onChange(of: refreshList) { _ in
                vm.getOrgs(9)
            }
        }
    }
}

//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationOrgList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un organisme"
    @State private var isEditing = false
    @State private var refreshList = false
    @ObservedObject var vm: ClothDonationViewModel
    @Binding var selectedCompany: Organization
    
    var body: some View {
        NavigationStackView("ClothsDonationOrgList") {
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
                        navigationModel.presentContent("ClothsDonationOrgList") {
                            CreateOrgView(type: "2", refresh: $refreshList)
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
                    ForEach(vm.orgs.filter({ searchString.isEmpty ? true : $0.name.contains(searchString)}), id:\.self) { org in
                        ListItemView(name: org.name)
                            .onTapGesture {
                                selectedCompany = org
                                vm.clothDonation.clothing_organization_detail = org.id
                                navigationModel.hideTopView()
                            }
                    }
                }
                .padding()
            }
        }
        .onDidAppear {
            vm.getOrgs()
        }
        .onChange(of: refreshList) { value in
            vm.getOrgs()
        }
    }
}

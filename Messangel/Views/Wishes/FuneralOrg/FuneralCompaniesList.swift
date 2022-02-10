//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct FuneralCompaniesList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un organisme"
    @State private var isEditing = false
    @State private var refreshList = false
    @Binding var selectedCompany: FuneralCompany
    @ObservedObject var vm: FuneralOrgViewModel
    
    var body: some View {
        NavigationStackView("FuneralCompaniesList") {
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
                            navigationModel.presentContent("FuneralCompaniesList") {
                                CreateOrgView(type: "4", refresh: $refreshList)
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
                    ForEach(vm.funeralCompanies.filter({ searchString.isEmpty ? true : $0.name.contains(searchString)}), id:\.self) { company in
                        ListItemView(name: company.name)
                                    .onTapGesture {
                                        selectedCompany = company
                                        vm.funeralOrg.funeral_company = company.id
                                        navigationModel.hideTopView()
                                    }
                            }
                }
                .padding()
            }
            .task {
                vm.getCompanies()
            }
            .onChange(of: refreshList) { value in
                vm.getCompanies()
        }
        }
            
    }
}

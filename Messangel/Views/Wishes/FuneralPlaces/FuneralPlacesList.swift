//
//  ContactsListView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlacesList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var auth: Auth
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un organisme"
    @State private var isEditing = false
//    @StateObject private var vm = ContactViewModel()
    @State private var compainies = ["Nom de l’organisme"]
    @Binding var selectedCompany: String
    
    var body: some View {
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
                    
    //                HStack(spacing: 2) {
    //                    Image(systemName: "arrow.up.arrow.down")
    //                        .foregroundColor(.white)
    //                        .padding(.trailing, 5)
    //                    Button(action: {
    ////                        vm.contacts.sort(by: { $0.first_name < $1.first_name })
    //                    }) {
    //                        Text("Prénom")
    //                            .foregroundColor(.white)
    //                            .underline()
    //                    }
    //                    Text("|")
    //                        .foregroundColor(.white)
    //                    Button(action: {
    ////                        vm.contacts.sort(by: { $0.last_name < $1.last_name })
    //                    }) {
    //                        Text("Nom")
    //                            .foregroundColor(.white)
    //                            .underline()
    //                    }
    //                    Spacer()
    //                }
                    
                    Spacer().frame(height: 20)
                    Button(action: {
                        compainies.append("Nom de l’organisme")
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
                    ForEach(compainies.filter({ searchString.isEmpty ? true : $0.contains(searchString)}), id:\.self) { company in
                            ListItemView(name: company)
                                .onTapGesture {
                                    selectedCompany = company
                                    navigationModel.hideTopView()
                                }
                        }
            }
            .padding()
        }
                
            
    }
}

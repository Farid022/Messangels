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
    @State private var searchString = ""
    @State private var placeholder = "    Rechercher un lieu"
    @State private var isEditing = false
    @ObservedObject var vm: FuneralLocationViewModel
    
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
                        Text("Sélectionnez un lieu")
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
//                    Button(action: {
//
//                    }) {
//                        RoundedRectangle(cornerRadius: 25.0)
//                            .fill(Color.accentColor)
//                            .frame(height: 56)
//                            .overlay(
//                                HStack {
//                                    Image("ic_add_org")
//                                        .padding(.leading)
//                                    Text("Nouvel lieu")
//                                        .foregroundColor(.white)
//                                    Spacer()
//                                }
//                            )
//                    }
//                    .padding(.bottom)
                ForEach(vm.buryLocations.filter({ searchString.isEmpty ? true : $0.name.contains(searchString)}), id:\.self) { location in
                    ListItemView(name: location.name) {
                        vm.name = location.name
                        vm.location.bury_location = location.id
                        navigationModel.hideTopView()
                    }
                }
            }
            .padding()
        }
        .onDidAppear {
            vm.getBuryLOcations { _ in
                
            }
        }
            
    }
}

//
//  SocialAccountsHomeView.swift
//  Messangel
//
//  Created by Saad on 12/17/21.
//

import SwiftUI
import NavigationStack

struct ServicesListView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showSearchBox = false
    @State private var searchString = ""
    @State private var selectedCategory = 0
    static let id = String(describing: Self.self)
    @StateObject private var vm = OnlineServiceViewModel()

    var body: some View {
        NavigationStackView(ServicesListView.id) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .edgesIgnoringSafeArea(.top)
                    .frame(height:70)
                VStack(spacing: 20) {
                    NavbarButtonView(title: "Ajouter un réseau social ou un") {}
                    NavigationTitleView(menuTitle: "service en ligne")
                    if !showSearchBox {
                        ScrollViewReader { scrollProxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Button {
                                        showSearchBox.toggle()
                                    } label: {
                                        VStack {
                                            Image("search_circle")
                                            Text("Rechercher")
                                                .font(.system(size: 13))
                                        }
                                    }
                                    .id(0)
                                    ForEach(vm.categories, id: \.self) { category in
                                        VStack {
                                            RoundedRectangle(cornerRadius: 22)
                                                .frame(width: 56, height: 56)
                                                .foregroundColor(selectedCategory == category.id ? .accentColor : .white)
                                                .overlay(
                                                    Image(category.name)
                                                        .renderingMode(.template)
                                                        .foregroundColor(selectedCategory == category.id ? .white : .accentColor)
                                                )
                                                .normalShadow()
                                            Text(category.name)
                                                .font(.system(size: 13))
                                        }
                                        .id(vm.categories.firstIndex(of: category)! + 1)
                                        .onTapGesture {
                                            selectedCategory = category.id
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .onAppear {
                                withAnimation(Animation.default.delay(0.5)) {
                                    scrollProxy.scrollTo(4)
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        scrollProxy.scrollTo(0)
                                        
                                    }
                                }
                            }
                        }
                    } else {
                        SearchFeildView(searchString: $searchString, showSearchBox: $showSearchBox)
                    }
                    HStack {
                        Text(showSearchBox ? "Ajout" : "Suggestions")
                            .foregroundColor(.gray)
                        Spacer()
                        if !showSearchBox {
                            Button {
                                
                            } label: {
                                Image("ic_refresh")
                            }
                        }
                    }
                    .padding(.top)
                    if !searchString.isEmpty {
                        ServiceCapsule(name: "Créer « \(searchString) »", newService: true)
                            .onTapGesture {
                                navigationModel.pushContent(ServicesListView.id) {
                                    NewServiceTypeView(name: searchString)
                                }
                            }
                    }
                    //&& selectedCategory > 0 ? $0.id == selectedCategory : true
                    ForEach(vm.services.filter { searchString.isEmpty && selectedCategory == 0 ? true : $0.name.lowercased().contains(searchString.lowercased()) || $0.category == selectedCategory }, id: \.self) { service in
                        ServiceCapsule(name: service.name)
                            .onTapGesture {
                                vm.service = service
                                navigationModel.pushContent(ServicesListView.id) {
                                    ServiceEmailView(serviceVM: vm)
                                }
                            }
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onDidAppear {
            vm.getCategories()
            vm.getServices()
        }
    }
}

struct ServiceCapsule: View {
    var name: String
    var icon = "ic_card"
    var newService = false
    var isList = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.white)
            .frame(height: 56)
            .normalShadow()
            .overlay(HStack {
                if !newService {
                    Image(icon)
                        .renderingMode(.template)
                        .foregroundColor(.accentColor)
                }
                Text(name)
                Spacer()
                if !isList {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .normalShadow()
                        .overlay(Image("ic_plus"))
                }
            }.padding())
    }
}



struct SearchFeildView: View {
    @State private var isEditing = false
    @State private var placeholder = "    Instagram, Netflix, Uber Eat"
    @Binding var searchString: String
    @Binding var showSearchBox: Bool
    
    var body: some View {
        TextField(placeholder, text: $searchString)
            .textFieldStyle(MyTextFieldStyle())
            .normalShadow()
            .onTapGesture {
                isEditing = true
                placeholder = ""
            }
            .if(!isEditing) {$0.overlay(
                HStack {
                    Button {
                        showSearchBox.toggle()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.accentColor)
                        
                            .padding(.leading, 8)
                    }
                    Spacer()
                }
            )}
            .padding(.top, 30)
    }
}

//struct SocialAccountsHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServicesListView()
//    }
//}

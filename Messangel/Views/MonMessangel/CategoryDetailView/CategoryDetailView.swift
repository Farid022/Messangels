//
//  CategoryDetailView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/16/22.
//

import SwiftUI
import NavigationStack

struct CategoryDetailView: View {
    
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var categoryDetailViewModel = CategoryDetailViewModel()
    
    var category :  ServiceCategory?
  
    var body: some View {
        
        NavigationStackView("CategoryDetailView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text(category?.name ?? "")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                        VStack(alignment:.leading){
                           
                            Text(category?.name ?? "")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            
                            Text("Liste de mes réseaux sociaux à gérer")
                                   .font(.system(size: 14))
                                   .fontWeight(.regular)
                                   .padding(.top,10)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                         
                            if categoryDetailViewModel.categories.count > 0
                            {
                            ZStack{
                                
                                Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                    .ignoresSafeArea()
                               
                                VStack{
                                
                                    ForEach(enumerating: categoryDetailViewModel.categories, id:\.self)
                                {
                                    index, item in
                                    CategoryDetailItem(type: "categoryDetailIcon", item: item.account_fields?.online_service?.name ?? "")
                                        .onTapGesture {
                                            
                                            navigationModel.pushContent("CategoryDetailView") {
                                                
                                                SocialNetworkSheetView(categoryDetail: item)
                                            }
                                        }
                                       

                                }
                                .padding(.trailing,24)
                                .padding(.leading,24)
                               
                                }
                                .padding(.top,40)
                                .padding(.bottom,40)
                                
                            }
                           
                            .cornerRadius(24)
                            .padding(.leading,18)
                            .padding(.trailing,18)
                            
                            
                            }
                           
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            
            categoryDetailViewModel.getCategoryDetail(categoryID: category?.id ?? 0)
            
        }
        }
    }
}

struct CategoryDetailItem: View
{
   
    var type: String
    var item: String
    var body: some View {
        
        VStack
        {
        HStack(alignment:.center)
        {
            
            if type.count > 0
            {
                Image(type)
                .padding(.leading,24)
                .cornerRadius(23)
                .frame(width:56,height:56)
             
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,12)
                
            }
            else
            {
                Image("categoryDetailIcon")
                .padding(.leading,24)
                .cornerRadius(23)
                .frame(width:56,height:56)
               
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,24)
            
             
                }
           
            Spacer()
            Rectangle()
            .foregroundColor(.white)
            .padding(.trailing,24)
            
        }
        .frame(height:56)
        .background(.white)
        .cornerRadius(22)
        .shadow(color: Color.init(red: 0, green: 0, blue: 0,opacity: 0.08), radius: 22, x: 0, y: 3)
       
        }
        .frame(height:68)
       
        
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: ServiceCategory(id: 0, name: ""))
    }
}

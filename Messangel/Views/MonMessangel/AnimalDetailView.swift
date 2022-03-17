//
//  AnimalDetailView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct AnimalDetailView: View {
    var animal : AnimalDetail
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject private var animalsViewModel = AnimalsViewModel()
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Animaux")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    
                    ScrollView {
                       
                        VStack(alignment:.leading)
                        {
                           
                          
                            Text(animal.animal_name)
                                    
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .multilineTextAlignment(.leading)
                                   .padding(.bottom,40)
                                   .padding(.leading,18)
                                  
                                 
                           
                            if animal.animal_photo.count > 0
                            {
                            AsyncImage(url: URL(string: animal.animal_photo)) { image in
                                image
                                .resizable()
                                .scaledToFill()
                            } placeholder: {
                                Image("animalPlaceholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:128, height: 128)
                                .clipShape(Circle())
                            }
                            .clipShape(Circle())
                            .frame(width:128, height: 128)
                            .padding(.leading,18)
                            }
                            else
                            {
                                Image("animalPlaceholder")
                                    .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:128, height: 128)
                                .padding(.leading,18)
                                .clipShape(Circle())
                            }
                               
                            HStack{
                               
                                
                                Image("giveTo")
                                    .padding(.leading,18)
                                Text("Donner à " + (animal.animal_contact_detail?.first_name ?? "") )
                                    
                                   .font(.system(size: 15))
                                   .fontWeight(.bold)
                                   .padding(.leading,12)
                                   .multilineTextAlignment(.leading)
                            }
                            .padding(.top,40)
                            .padding(.bottom,24)
                            
                           
                           
                          
                            
                            if animal.single_animal == false
                            {
                                
                                HStack{
                                   
                                    
                                    Image("ic_i")
                                        .padding(.leading,18)
                                    Text("Espèce – " + animal.animal_species)
                                        
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .padding(.leading,12)
                                       .multilineTextAlignment(.leading)
                                }
                                .padding(.bottom,24)
                                
                                
                            HStack{
                               
                                
                                Image("ic_i")
                                    .padding(.leading,18)
                                
                                
                            Text("Plusieurs animaux")
                                
                                   .font(.system(size: 15))
                                   .fontWeight(.regular)
                                   .padding(.leading,12)
                                   .multilineTextAlignment(.leading)
                            }
                            .padding(.bottom,40)
                            }
                              
                            
                            if animal.animal_note.count > 0 || animal.animal_note_attachment?.count ?? 0 > 0
                            {
                            Group
                            {
                                ZStack{
                                    Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                        .ignoresSafeArea()
                                   
                         
                                    
                     
                            VStack(alignment:.leading)
                            {
                                     
                        
                                Group
                                {
                                if animal.animal_note.count > 0
                                {
                                    MonCercueilItem(title: "", description: animal.animal_note, image: "")
                                }
                                else
                                {
                                    MonCercueilItem(title: "", description:"", image: "")
                                }
                              
                                
                              
                                LazyVGrid(columns: columns) {
                                                ForEach(enumerating: animal.animal_note_attachment ?? [], id:\.self)
                                                {
                                                    index, item in
                                                    gridItem(title: item)
                                                    
                                                }
                                            }
                                    .padding(.leading,24)
                                    .padding(.trailing,24)
                                    .padding(.bottom,40)
                                
                                
                                }
                                
                                }
                                        
                                        
                                        
                                }
                                }
                                .cornerRadius(24)
                                .padding(.leading,18)
                                .padding(.trailing,18)
                               
                               
                            }
                            else
                            {
                                LazyVGrid(columns: columns) {
                                                ForEach(enumerating: animal.animal_note_attachment ?? [], id:\.self)
                                                {
                                                    index, item in
                                                    gridItem(title: item)
                                                    
                                                }
                                            }
                                    .padding(.leading,24)
                                    .padding(.trailing,24)
                                    .padding(.bottom,0)
                            }
                            
                            
                         }
                        
                        
                       
                    }
                
                }
            }
        }
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
 
    
    static var previews: some View {
      
        
        AnimalDetailView(animal: AnimalDetail(single_animal: true, animal_name: "", animal_contact_detail: Contact(id: 0, user: getUserId(), first_name: "", last_name: "", email: "", phone_number: "", legal_age: true), animal_organization_detail: Organismes(), animal_species: "", animal_note: "", animal_photo: "", user: User(id: nil, first_name: "", last_name: "", email: "", password: "", phone_number: "", dob: "", city: "", postal_code: "", gender: "", is_active: false, image_url: nil)))
    }
}

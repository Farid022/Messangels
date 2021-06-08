//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var lastName = "Sophie"
    @State private var firstName = "Carnero"
    @State private var postCode = "75008"
    @State private var gender = "Féminin"
    var body: some View {
        MenuBaseView(title:"Profil") {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 66, height: 66)
                .cornerRadius(30)
                .overlay(Image("ic_camera"))
            Text("Choisir une photp")
                .foregroundColor(.secondary)
                .font(.system(size: 13))
                .padding(.bottom)
            HStack {
                Text("Né(e) le 6 juin 1980 à Paris")
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("", text: $lastName)
                TextField("", text: $firstName)
                TextField("", text: $postCode)
                TextField("", text: $gender)
            }
            .textFieldStyle(MyTextFieldStyle(editable: true))
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Button("Enregister") {
                
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
            .padding(.bottom)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Supprimer mon compte")
                    .underline()
                    .accentColor(.red)
                    .font(.system(size: 11))
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  AddContactView.swift
//  Messangel
//
//  Created by Saad on 5/25/21.
//

import SwiftUI
import NavigationStack

struct CreateContactView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var mailAddress = ""
    @State private var mobile = ""
    @State private var legalAge = false
    @State private var minorAge = false
    @State private var isValid = false
    
    @State private var dob_day = 1
    @State private var dob_month = "AVRIL"
    @State private var dob_year = 2001
    
    var body: some View {
        MenuBaseView(title: "Créer un contact") {
            HStack {
                Text("Coordonnées du contact")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 20)
            Group {
                TextField("Prénom", text: $lastName)
                TextField("Nom", text: $firstName)
                TextField("Adresse mail", text: $mailAddress)
                TextField("Numéro de téléphone mobile", text: $mobile)
            }
            .textFieldStyle(MyTextFieldStyle())
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Spacer().frame(height: 20)
            HStack {
                VStack {
                    Group {
                        Toggle("Cette personne est majeure", isOn: $legalAge)
                            .onChange(of: legalAge) { value in
                                isValid = legalAge
                            }
                        Toggle("Cette personne est mineure", isOn: $minorAge)
                            .onChange(of: minorAge) { value in
                                isValid = minorAge
                            }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.bottom, 30)
                }
                Spacer()
            }
            if minorAge {
                Text("Si cette personne est encore mineure au moment de votre décès, vos messages seront envoyés à vos Anges-gardiens.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                    .padding(.bottom)
                HStack {
                    Text("Date de naissance du destinataire")
                    Spacer()
                }
                MyDatePickerView(day: $dob_day, month: $dob_month, year: $dob_year)
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .padding(.bottom, 20)
            }
            Button(action: {
                if isValid {
                    navigationModel.hideTopViewWithReverseAnimation()
                }
            }){
                HStack {
                    Image("ic_add-user")
                    Text("Créer")
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        
            CreateContactView()
        
    }
}

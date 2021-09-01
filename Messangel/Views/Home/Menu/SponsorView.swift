//
//  SponsorView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct SponsorView: View {
    @State private var legalAge = false
    @State private var alert = false
    @StateObject private var vm = SponsorViewModel()
    @EnvironmentObject private var auth: Auth
    
    var body: some View {
        MenuBaseView(title: "Parrainer un proche") {
            Text("Conseillez Messangel à un ami ou un proche. Votre filleul bénéficiera de 6 mois d’abonnement gratuit dès son inscription.")
                .foregroundColor(.secondary)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .padding()
            HStack {
                Text("Personne à parrainer")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("Prénom", text: $vm.sponsor.first_name)
                TextField("Nom", text: $vm.sponsor.last_name)
                TextField("Adresse mail", text: $vm.sponsor.email)
            }
            .textFieldStyle(MyTextFieldStyle())
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Toggle(isOn: $legalAge, label: {
                Text("Je certifie que cette personne est majeure.")
                    .font(.system(size: 15))
            })
            .toggleStyle(CheckboxToggleStyle())
            .padding(.bottom)
            Button("Envoyer un mail") {
                vm.sponsor.user = auth.user.id ?? 0
                vm.sendInvitation {
                    alert.toggle()
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .black))
            .shadow(color: .gray.opacity(0.2), radius: 10)
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(vm.apiResponse.message.isEmpty ? vm.apiError.error : "Modifier mot de passe"), message: Text(vm.apiResponse.message.isEmpty ? vm.apiError.error_description : vm.apiResponse.message))
        })
    }
}

//struct SponsorView_Previews: PreviewProvider {
//    static var previews: some View {
//            SponsorView()
//    }
//}

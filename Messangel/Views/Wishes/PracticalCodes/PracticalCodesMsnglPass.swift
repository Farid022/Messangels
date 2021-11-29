//
//  AdminDocs.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodesMsnglPass: View {
    @State private var password = ""
    var body: some View {
        NavigationStackView("PracticalCodesMsnglPass") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack {
                    BackButton()
                    Spacer()
                    Image("ic_lock_white")
                        .padding(.bottom)
                    Group {
                        Text("Accès sécurisé.")
                        Text("Entrez votre mot de passe Messangel ")
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 17), weight: .bold)
                    SecureField("Mot de passe", text: $password)
                        .padding(.bottom, 30)
                        .textFieldStyle(MyTextFieldStyle())
                    MyLink(url: "https://google.com/", text: "Politique de confidentialité")
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "PracticalCodesMsnglPass", destination: AnyView(PracticalCodesOTP()), active: .constant(!password.isEmpty))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

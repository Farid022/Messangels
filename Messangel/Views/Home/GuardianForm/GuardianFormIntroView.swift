//
//  GuardianFormView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct GuardianFormIntroView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var body: some View {
        NavigationStackView("GuardianFormIntroView") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton()
                    Spacer()
                    Text("Ajouter un Ange-gardien")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("""
                        Indiquez les coordonnées d’une personne à qui vous confierez votre Messangel.

                        Cette personne devra accepter votre demande par mail.
                        """)
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "GuardianFormIntroView", destination: AnyView(GuardianFormLastNameView()), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

struct GuardianFormView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormIntroView()
    }
}

//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateIntro: View {

    var body: some View {
        NavigationStackView("OrganDonateIntro") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton(icon:"xmark")
                    Spacer()
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .normalShadow()
                            .overlay(Image("info"))
                        Spacer()
                    }
                    .padding(.bottom)
                    Text("Don d’organes ou du corps à la science")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez vos choix concernant le don d’organes ou du corps à la science. Nous vous recommandons de consulter le guide Messangel avant de commencer cette séquence, et d’en parler avec vos proches.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "OrganDonateIntro", destination: AnyView(OrganDonateChoice()), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

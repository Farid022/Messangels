//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgsIntro: View {

    var body: some View {
        NavigationStackView("DonationOrgsIntro") {
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
                    Text("Dons et collectes")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez les organismes auxquelles vous souhaitez faire un don. Vous pourrez également apporter des précisions sur chacun de vos dons (exemples ?).")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "DonationOrgsIntro", destination: AnyView(DonationOrgNew()), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

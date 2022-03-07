//
//  AdminDocs.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodesIntro: View {
    var body: some View {
        NavigationStackView("PracticalCodesIntro") {
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
                    Text("Codes pratiques")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez vos codes pratiques : Ordinateurs, alarmes, digicodes, coffres, cadenas…")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "PracticalCodesIntro", destination: AnyView(PracticalCodeNew()), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralChoiceIntro: View {

    var body: some View {
        NavigationStackView("FuneralChoiceIntro") {
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
                    Text("Choix funéraires")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("""
                        Cette séquence vous permet d’indiquer si vous souhaitez être inhumé ou crématisé. Vous pourrez également préciser vos souhaits concernant le cercueil, l’urne (cas échéant) ainsi que votre tenue.
                        """)
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralChoiceIntro", destination: AnyView(FuneralTypeView()), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

struct FuneralChoiceIntro_Previews: PreviewProvider {
    static var previews: some View {
        FuneralChoiceIntro()
    }
}

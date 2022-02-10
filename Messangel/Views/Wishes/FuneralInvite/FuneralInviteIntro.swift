//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralInviteIntro: View {
    @StateObject private var vm = FuneralAnnounceViewModel()
    
    var body: some View {
        NavigationStackView("FuneralInviteIntro") {
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
                    Text("Annonces")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez vos souhaits sur l’apparence de votre faire-part : photo, thème visuel, symboles… La composition finale sera laissée à l’appréciation de vos proches. Vous pouvez également indiquer si vous souhaitez que votre annonce apparaisse dans un journal local en particulier.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralInviteIntro", destination: AnyView(FuneralInvitePic(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}

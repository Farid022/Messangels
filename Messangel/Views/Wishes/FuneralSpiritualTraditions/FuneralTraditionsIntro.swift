//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralTraditionsIntro: View {
    @StateObject private var vm = FuneralSpritualityViewModel()
    
    var body: some View {
        NavigationStackView("FuneralTraditionsIntro") {
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
                    Text("Spiritualité et traditions")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez si votre cérémonie intégrera des aspects religieux, philosophiques ou traditionnels. ")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralTraditionsIntro", destination: AnyView(SpiritualTraditionChoice(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.spritualities.count > 0 {
                        let i = vm.spritualities[0]
                        vm.sprituality = FuneralSprituality(spritual_ceremony: i.spritual_ceremony.id, ceremony_note: i.ceremony_note)
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}

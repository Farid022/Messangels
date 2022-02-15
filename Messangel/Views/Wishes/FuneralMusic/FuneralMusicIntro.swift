//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicIntro: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = FuneralMusicViewModel()
    @State private var gotList = false

    var body: some View {
        NavigationStackView("FuneralAestheticIntro") {
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
                    Text("Musique")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez les titres qui vous sont chers, afin qu’il puissent être diffusés lors de votre cérémonie. Vous pourrez aussi apporter des précisions (moment de diffusion, interprétation live…).")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent("FuneralAestheticIntro") {
                                if vm.musics.isEmpty {
                                    FuneralMusicNew(vm: vm)
                                } else {
                                    FuneralMusicList(vm: vm, refresh: false)
                                }
                            }
                        }, active: .constant(gotList))
                            .animation(.default, value: gotList)
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear() {
            vm.getMusics { _ in
                gotList.toggle()
            }
        }
    }
}

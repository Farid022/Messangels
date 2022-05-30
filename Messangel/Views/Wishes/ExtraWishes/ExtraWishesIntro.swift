//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ExtraWishesIntro: View {
    @StateObject private var vm = ExtraWishViewModel()
    var body: some View {
        NavigationStackView("ExtraWishesIntro") {
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
                    Text("Expression libre")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Exprimez-vous librement sur vos volontés. Ces éléments compléteront les choix que vous avez déjà exprimés au travers des séquences Messangel.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "ExtraWishesIntro", destination: AnyView(ExtraWishesDetails(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.extraWishes.count > 0 {
                        vm.extraWish = ExtraWish(express_yourself_note: vm.extraWishes[0].express_yourself_note, user: getUserId())
                        vm.extraWish.express_yourself_note_attachments = addAttacments(vm.extraWishes[0].express_yourself_note_attachment)
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}

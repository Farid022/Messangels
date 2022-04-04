//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralChoiceIntro: View {
    @StateObject private var vm = FeneralViewModel()
    @EnvironmentObject var wishVM: WishesViewModel
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
                        NextButton(source: "FuneralChoiceIntro", destination: AnyView(FuneralTypeView(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.funeralChoices.count > 0 {
                        vm.funeral = Funeral(place_burial_note: vm.funeralChoices[0].placeBurialNote, handle_note: vm.funeralChoices[0].handleNote, religious_sign_note: vm.funeralChoices[0].religiousSignNote, outfit_note: vm.funeralChoices[0].outfitNote, acessories_note: vm.funeralChoices[0].acessoriesNote, deposite_ashes_note: vm.funeralChoices[0].depositeAshesNote, burial_type: vm.funeralChoices[0].burialType.id, burial_type_note: vm.funeralChoices[0].burial_type_note, coffin_material: vm.funeralChoices[0].coffinMaterial.id, coffin_finish: vm.funeralChoices[0].coffinFinish.id, internal_material: vm.funeralChoices[0].internalMaterial.id, urn_material: vm.funeralChoices[0].urnMaterial?.id, urn_style: vm.funeralChoices[0].urnStyle?.id, user: getUserId())
                        vm.updateRecord = true
                        vm.recordId = vm.funeralChoices[0].id
                        vm.progress = wishVM.wishesProgresses.last(where: {$0.tab == Wishes.choices.rawValue})?.progress ?? 0
                    }
                }
            }
        }
    }
}

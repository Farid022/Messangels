//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralAestheticIntro: View {
    @StateObject private var vm = FueneralAstheticViewModel()
    @EnvironmentObject var wishVM: WishesViewModel
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
                    Text("Esthétique")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Anticipez les détails estéthiques de votre cérémonie comme le choix des fleurs, la décoration ou la tenue des invités… Vous pouvez consulter le Guide Messangel pour vous accompagner dans vos choix.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralAestheticIntro", destination: AnyView(FuneralFlowers(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.asthetics.count > 0 {
                        let i = vm.asthetics[0]
                        vm.asthetic = FueneralAsthetic(special_decoration_note: i.special_decoration_note, attendence_dress_note: i.attendence_dress_note, guest_accessories_note: i.guest_accessories_note, flower: i.flower.map({$0.id}), flower_note: i.flower_note)
                        vm.asthetic.special_decoration_note_attachments = addAttacments(i.special_decoration_note_attachment)
                        vm.asthetic.attendence_dress_note_attachments = addAttacments(i.attendence_dress_note_attachment)
                        vm.asthetic.guest_accessories_note_attachments = addAttacments(i.guest_accessories_note_attachment)
                        vm.asthetic.flower_note_attachments = addAttacments(i.flower_note_attachment)
                        vm.updateRecord = true
                        vm.recordId = i.id
                        vm.progress = wishVM.wishesProgresses.last(where: {$0.tab == Wishes.aesthetics.rawValue})?.progress ?? 0
                    }
                }
            }
        }
    }
}

func addAttacments(_ attachments: [Attachement]?) -> [URL] {
    var urls = [URL]()
    if let attachments = attachments {
        for attachment in attachments {
            if let url = URL(string: attachment.url) {
                urls.append(url)
            }
        }
    }
    return urls
}

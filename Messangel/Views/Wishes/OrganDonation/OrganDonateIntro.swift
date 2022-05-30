//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateIntro: View {
    @StateObject private var vm = OrganDonationViewModel()
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
                        NextButton(source: "OrganDonateIntro", destination: AnyView(OrganDonateChoice(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.donations.count > 0 {
                        let i = vm.donations[0]
                        vm.donation = OrganDonation(register_to_national: i.register_to_national, register_to_national_note: i.register_to_national_note, register_to_national_note_attachments: addAttacments(i.register_to_national_note_attachment), donation: i.donation.id, donation_note: i.donation_note, donation_note_attachments: addAttacments(i.donation_note_attachment))
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}

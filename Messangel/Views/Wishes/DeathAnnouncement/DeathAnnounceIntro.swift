//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct DeathAnnounceIntro: View {
    @StateObject private var vm = PriorityContactsViewModel()

    var body: some View {
        NavigationStackView("DeathAnnounceIntro") {
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
                    Text("Diffusion de la nouvelle")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez les personnes auxquelles vos Anges-Gardiens devront annoncer votre décès en priorité. Ces personnes pourront relayer l’information auprès de vos différentes sphères relationnelles : famille, amis, professionnel, associatif ou autres.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "DeathAnnounceIntro", destination: AnyView(DeathAnnounceContacts(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.priorities.count > 0 {
                        let i = vm.priorities[0]
                        vm.priorityContacts = PriorityContacts(contact: [], priority_note: i.priority_note)
                        i.contact.forEach { contact in
                            vm.priorityContacts.contact.append(contact.id)
                        }
                        vm.priorityContacts.priority_note_attachments = addAttacments(i.priority_note_attachment)
                        vm.contacts = i.contact
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}

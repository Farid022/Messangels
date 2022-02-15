//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct OrganDonateBody: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var loading = false
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    private let  title = "Pour donner votre corps à la science, vous devez effectuer des démarches auprès d’organismes spécialisés."

    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                if !vm.updateRecord {
                    vm.create() { success in
                        loading.toggle()
                        if success {
                            wishChoiceSuccessAction(title, navModel: navModel)
                        }
                    }
                } else {
                    vm.update(id: vm.donations[0].id) { success in
                        loading.toggle()
                        if success {
                            wishChoiceSuccessAction(title, navModel: navModel)
                        }
                    }
                }
            },note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: title, valid: .constant(true)) {
                viewMessangelGuide()
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
            
        }
    }
}

func viewMessangelGuide() -> some View {
    return HStack {
        Button(action: {
            
        }, label: {
            Text("Voir notre guide Messangel")
        })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
        Spacer()
    }
}

func wishChoiceSuccessAction(_ title: String, navModel: NavigationModel) {
    navModel.pushContent(title) {
        FuneralDoneView()
    }
}

//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct OrganDonateBody: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: OrganDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
                UserDefaults.standard.set(100.0, forKey: wishesPersonal[2].id)
                vm.create() { success in
                    if success {
                        navModel.pushContent("Pour donner votre corps à la science, vous devez effectuer des démarches auprès d’organismes spécialisés.") {
                            FuneralDoneView()
                        }
                    }
                }
            },note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Pour donner votre corps à la science, vous devez effectuer des démarches auprès d’organismes spécialisés.", valid: .constant(true)) {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Voir notre guide Messangel")
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
                    Spacer()
                }
            }
            
        }
    }
}

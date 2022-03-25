//
//  KeyAccRegChoiceView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct KeyAccRegChoiceView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var showNote = false
    @State private var loading = false
    @State private var note = ""
    @ObservedObject var vm: KeyAccViewModel
    var keyAccCase: KeyAccCase
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.keyEmailAcc.note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 3.0, totalSteps: 6.0, isCustomAction: true, customAction: {
                loading.toggle()
                vm.addPrimaryEmailAcc { success in
                    loading.toggle()
                    if success {
                        if keyAccCase == .register {
                            navigationModel.pushContent("\(vm.keyEmailAcc.email) - Que souhaitez-vous faire de ce compte après votre départ?") {
                                KeyAccRegPhoneNameView(vm: vm)
                            }
                        } else {
                            vm.getKeyAccounts { success in
                                if success {
                                    navigationModel.popContent(KeyMailsAndPhonesView.id)
                                }
                            }
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Comptes-clés", title: "\(vm.keyEmailAcc.email) - Que souhaitez-vous faire de ce compte après votre départ?", valid: .constant(vm.keyEmailAcc.deleteAccount != nil)) {
                
                HStack {
                    ForEach([true, false], id: \.self) { choice in
                        ChoiceCard(text: choice ? "Supprimer le compte" : "Gérer le compte (Note)", selected: .constant(vm.keyEmailAcc.deleteAccount == choice))
                            .onTapGesture {
                                vm.keyEmailAcc.deleteAccount = choice
                            }
                    }
                }
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

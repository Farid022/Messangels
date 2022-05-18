//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack
//Have you subscribed to a funeral contract?
struct FuneralHaveContractView: View {
    @EnvironmentObject private var navModel: NavigationModel
    @State private var loading = false
    @State private var showNote = false
    @ObservedObject var vm: FuneralOrgViewModel
    private let title = "Avez-vous souscrit à un contrat obsèques ?"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.funeralOrg.company_contract_detail_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                if let subscribed = vm.funeralOrg.company_contract_detail, subscribed {
                    navModel.pushContent(title) {
                        FuneralContractCompanyView(vm: vm)
                    }
                } else {
                    loading.toggle()
                    if !vm.updateRecord {
                        vm.create() { success in
                            if success {
                                WishesViewModel.setProgress(tab: 2) { completed in
                                    loading.toggle()
                                    if completed {
                                        successAction(title, navModel: navModel)
                                    }
                                }
                            }
                        }
                    } else {
                        vm.update(id: vm.funeralOrgs[0].id) { success in
                            loading.toggle()
                            if success {
                                successAction(title, navModel: navModel)
                            }
                        }
                    }
                }
                
            },note: true, showNote: $showNote, menuTitle: "Organismes obsèques", title: title, valid: .constant(vm.funeralOrg.company_contract_detail != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { subscribed in
                        ChoiceCard(text: subscribed ? "Oui" : "Non", selected: .constant(vm.funeralOrg.company_contract_detail == subscribed))
                            .onTapGesture {
                                vm.funeralOrg.company_contract_detail = subscribed
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

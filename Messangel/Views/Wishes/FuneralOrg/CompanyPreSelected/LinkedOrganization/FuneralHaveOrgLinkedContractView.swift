//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack
//Do you have a funeral contract linked to another organization?
struct FuneralHaveOrgLinkedContractView: View {
    @EnvironmentObject private var navModel: NavigationModel
    @State private var showNote = false
    @State private var loading = false
    @State private var note = ""
    @ObservedObject var vm: FuneralOrgViewModel
    var companyName: String
    private let title = "Avez-vous un contrat obsèques relié à un autre organisme ?"
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(isCustomAction: true, customAction: {
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
                
            },note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: title, valid: .constant(vm.funeralOrg.company_contract_detail != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { type in
                        ChoiceCard(text: type ? "Oui" : "Non", selected: .constant(vm.funeralOrg.company_contract_detail == type))
                            .onTapGesture {
                                vm.funeralOrg.company_contract_detail = type
                            }
                    }
                }
            }
        }
    }
}

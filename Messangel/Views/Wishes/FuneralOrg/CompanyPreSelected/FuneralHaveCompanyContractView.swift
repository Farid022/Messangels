//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
//Do you have a funeral contract linked to * NAME OF THE FUNERAL COMPANY?
struct FuneralHaveCompanyContractView: View {
    @State private var showNote = false
    @ObservedObject var vm: FuneralOrgViewModel
    var companyName: String
    var title: String {
        return "Avez-vous un contrat obsèques relié à \(companyName) ?"
    }
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $vm.funeralOrg.company_contract_detail_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 3.0, totalSteps: 4.0,noteText: $vm.funeralOrg.company_contract_detail_note.bound, note: true, showNote: $showNote, menuTitle: "Organismes obsèques", title: title, valid: .constant(vm.funeralOrg.company_contract_detail != nil), destination: vm.funeralOrg.company_contract_detail ?? true ? AnyView(FuneralContractNo(vm: vm)): AnyView(FuneralHaveOrgLinkedContractView(vm: vm, companyName: companyName))) {
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

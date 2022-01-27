//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct FuneralContractNo: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @ObservedObject var vm: FuneralOrgViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: "Indiquez votre numéro de contrat obsèques", valid: .constant(!vm.funeralOrg.company_contact_num.isEmpty), destination: AnyView(FuneralDoneView())) {
                TextField("Numéro de contrat obsèques", text: $vm.funeralOrg.company_contact_num)
                    .normalShadow()
            }
            
        }
    }
}

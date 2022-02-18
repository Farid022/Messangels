//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralOrgIntro: View {
    @StateObject private var vm = FuneralOrgViewModel()
    
    var body: some View {
        NavigationStackView("FuneralOrgIntro") {
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
                    Text("Organismes spécialisés")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez si vous êtes relié à une entreprise funéraire, ou si vous avez souscrit à un contrat obsèques.")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralOrgIntro", destination: AnyView(FuneralCompanyIsPreSelectedView(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.funeralOrgs.count > 0 {
                        let i = vm.funeralOrgs[0]
                        vm.funeralOrg = FuneralOrg(chose_funeral_home: i.chose_funeral_home, funeral_company: i.funeral_company?.id, funeral_company_note: i.funeral_company_note, company_contract_detail: i.company_contract_detail, company_contract_num: i.company_contract_num, funeral_contract: i.funeral_contract.id)
                        if let orgName = i.funeral_company?.name {
                            vm.orgName = orgName
                        }
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}

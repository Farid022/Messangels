//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ManagedContractsDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: ContractViewModel
    var contract: ContractSever
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce contract") {
                vm.del(id: contract.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: ManagedContractsList.self))
                        vm.getAll { _ in }
                    }
                }
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        NavigationTitleView(menuTitle: "Contrats à gérer")
                        DetailsTitleView(title: contract.name)
                        HStack {
                            Image("ic_item_info")
                            Text(contract.organization.name)
                            Spacer()
                        }
                        DetailsNoteView(note: contract.note, attachments: vm.attachements, navId: String(describing: Self.self))
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.contract = ContractLocal(id: contract.id, contract_name: contract.name, contract_organization: contract.organization.id ?? 1, contract_note: contract.note)
                            vm.orgName = contract.organization.name
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                ManagedContractName(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

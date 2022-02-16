//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AdminDocsDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: AdminDocViewModel
    var docs: AdminDocServer
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce donation") {
                vm.del(id: docs.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: AdminDocsList.self))
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
                        NavbarButtonView()
                        NavigationTitleView(menuTitle: "Pièces administratives")
                        HStack {
                            BackButton(iconColor: .gray)
                            Text("Pièce d’identité")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        DetailsNoteView(note: docs.note)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.adminDoc = AdminDocLocal(id: docs.id, document_name: docs.name, document_note: docs.note)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                AdminDocsName(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodeDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: PracticalCodeViewModel
    var practicalCode: PracticalCodeDetail
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce code") {
                vm.del(id: practicalCode.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: PracticalCodesList.self))
                        vm.getPracticalCodes { _ in }
                    }
                }
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        NavigationTitleView(menuTitle: "Codes pratiques", showExitAlert: .constant(false))
                        HStack {
                            BackButton(iconColor: .gray)
                            Text(practicalCode.name)
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_lock_color_native")
                            Text("•••••• (Code 1)")
                            Spacer()
                        }
                        HStack {
                            Image("ic_lock_color_native")
                            Text("•••••••• (Code 2)")
                            Spacer()
                        }
                        DetailsNoteView(note: practicalCode.note)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.practicalCode = PracticalCode(id: practicalCode.id, name: practicalCode.name, codes: [], note: practicalCode.note)
                            practicalCode.codes.forEach { code in
                                vm.practicalCode.codes.append(code.id ?? 1)
                            }
                            vm.practicalCode.note_attachments = addAttacments(practicalCode.note_attachment)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                PracticalCodeName(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

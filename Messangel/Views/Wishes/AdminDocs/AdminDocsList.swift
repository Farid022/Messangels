//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct AdminDocsList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: AdminDocViewModel
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "Pièces administratives", newItemView: AnyView(AdminDocsName(vm: AdminDocViewModel()))) {
            ForEach(vm.adminDocs, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            AdminDocsDetails(vm: vm, docs: item)
                        }
                    }
            }
        }
        .task {
            if refresh {
                vm.getAll { _ in }
            }
        }
    }
}



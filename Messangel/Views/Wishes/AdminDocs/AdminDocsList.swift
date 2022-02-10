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
    
    var body: some View {
        FuneralItemList(id:"AdminDocsList", menuTitle: "Pièces administratives") {
            ForEach(vm.adminDocs, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent("AdminDocsList") {
                            AdminDocsDetails(title: item.name, note: item.note)
                        }
                    }
            }
        }
        .task {
            vm.getAll()
        }
    }
}



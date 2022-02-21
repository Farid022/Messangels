//
//  ClothsDonationsList.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodesList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: PracticalCodeViewModel
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id: String(describing: Self.self), menuTitle: "Codes pratiques", newItemView: AnyView(PracticalCodesMsnglPass(vm: PracticalCodeViewModel()))) {
            ForEach(vm.practicalCodes, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            PracticalCodeDetails(vm: vm, practicalCode: item)
                        }
                    }
            }
        }
        .onDidAppear {
            if refresh {
                vm.getPracticalCodes { _ in }
            }
        }
    }
}



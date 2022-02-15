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
    
    var body: some View {
        FuneralItemList(id:"PracticalCodesList", menuTitle: "Codes pratiques", newItemView: AnyView(PracticalCodesMsnglPass(vm: PracticalCodeViewModel()))) {
            ForEach(vm.practicalCodes, id: \.self) { item in
                FuneralItemCard(title: item.name, icon: "ic_doc")
                    .onTapGesture {
                        navigationModel.pushContent("PracticalCodesList") {
                            PracticalCodeDetails(title: item.name, note: item.note)
                        }
                    }
            }
        }
        .onDidAppear {
            vm.getPracticalCodes { _ in }
        }
    }
}



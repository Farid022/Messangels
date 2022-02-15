//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct PracticalCodeNew: View {
    @ObservedObject var vm: PracticalCodeViewModel
    var body: some View {
        FuneralNewItemView(menuTitle: "Codes pratiques", title: "Ajoutez vos codes pratiques", destination: AnyView(PracticalCodesMsnglPass(vm: vm)))

    }
}



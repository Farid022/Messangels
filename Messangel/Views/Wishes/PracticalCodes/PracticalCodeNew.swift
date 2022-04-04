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
        FuneralNewItemView(totalSteps: 3.0, menuTitle: "Codes pratiques", title: "Ajoutez vos codes pratiques", destination: AnyView(PracticalCodesMsnglPass(vm: vm)))

    }
}



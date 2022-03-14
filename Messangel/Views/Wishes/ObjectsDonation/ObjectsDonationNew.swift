//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct ObjectsDonationNew: View {
    @ObservedObject var vm: ObjectDonationViewModel
    var body: some View {
        FuneralNewItemView(totalSteps: 7.0, menuTitle: "Objets", title: "Ajoutez vos premiers objets", destination: AnyView(ObjectsDonationCount(vm: vm)))

    }
}



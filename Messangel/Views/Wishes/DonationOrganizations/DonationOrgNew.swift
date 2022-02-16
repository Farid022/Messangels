//
//  ClothsDonationNew.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI

struct DonationOrgNew: View {
    @ObservedObject var vm: DonationOrgViewModel
    var body: some View {
        FuneralNewItemView(menuTitle: "Dons et collectes", title: "Ajoutez votre premier organisme (association, fondation…)", destination: AnyView(DonationOrgsSelectionView(vm: vm)))

    }
}



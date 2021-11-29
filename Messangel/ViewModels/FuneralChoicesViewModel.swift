//
//  FuneralChoicesViewModel.swift
//  Messangel
//
//  Created by Saad on 10/21/21.
//

import Foundation

enum FuneralType: CaseIterable {
    case none
    case burial
    case crematization
}

enum FuneralRestPlace: CaseIterable {
    case none
    case funeral_place
    case residence
}

enum SpiritualType: CaseIterable {
    case none
    case non_religious
    case religious
}

enum FuneralBool: CaseIterable {
    case none
    case yes
    case no
}

enum ClothsDonationType: CaseIterable {
    case none
    case single
    case multiple
}

enum ClothsDonationPlace: CaseIterable {
    case none
    case contact
    case organization
}

enum OrganDonChoice: CaseIterable {
    case none
    case organs
    case deny
    case body
}
